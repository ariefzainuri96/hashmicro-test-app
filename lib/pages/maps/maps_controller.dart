import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hashmicro_test_apps/common_functions.dart';
import 'package:hashmicro_test_apps/config/enums.dart';
import 'package:hashmicro_test_apps/pages/attendance/model/locations_response.dart';
import 'package:hashmicro_test_apps/repository/location_repository.dart';
import 'package:latlong2/latlong.dart';

class MapsController extends GetxController {
  final locationRepo = LocationRepositoryImpl();
  final MapController mapController = MapController();

  TextEditingController locationNameController = TextEditingController();
  LatLng? tappedLatLng;
  LatLng currentPosition = const LatLng(0.0, 0.0);
  bool isGetCurrentPositionLoading = false;
  String locationName = '';
  List<LocationObj> locationList = [];
  RequestState fetchLocationState = RequestState.IDLE;

  void getLocation() async {
    showDialogLoading(dismissable: true, text: 'Fetch locations...');
    final response = await locationRepo.getLocations();
    closeDialogLoading();
    fetchLocationState = (response?.status ?? 400) == 200
        ? RequestState.SUCCESS
        : RequestState.ERROR;

    locationList.assignAll(response?.data ?? []);
    update();
  }

  determinePosition() async {
    if (!(await checkLocationPermission())) return;

    if (isGetCurrentPositionLoading) return;

    isGetCurrentPositionLoading = true;
    update();
    final position = await Geolocator.getCurrentPosition();
    isGetCurrentPositionLoading = false;

    currentPosition = LatLng(position.latitude, position.longitude);

    update();

    Future.delayed(const Duration(milliseconds: 500),
        () => mapController.move(currentPosition, 18));
  }

  void addLocation() async {
    if (tappedLatLng == null) return;

    showDialogLoading(dismissable: false, text: 'Add location...');

    final body = {
      "name": locationName,
      "latitude": tappedLatLng!.latitude,
      "longitude": tappedLatLng!.longitude
    };
    final response = await locationRepo.addLocation(body: body);
    closeDialogLoading();

    showSnackbar(
        '${(response?.status ?? 400) == 200 ? 'Berhasil' : 'Gagal'} menambahkan location!');

    locationNameController.clear();
    tappedLatLng = null;
    update();
  }

  @override
  void onInit() {
    determinePosition();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      getLocation();
    });
    super.onInit();
  }

  @override
  void onClose() {
    locationNameController.dispose();
    mapController.dispose();
    super.onClose();
  }
}
