import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hashmicro_test_apps/common_functions.dart';
import 'package:hashmicro_test_apps/config/enums.dart';
import 'package:hashmicro_test_apps/repository/attendance_repository.dart';

class AttendanceController extends GetxController {
  final attendanceRepo = AttendanceRepositoryImpl();

  RequestState attendanceState = RequestState.IDLE;
  String name = '';
  String errorMessage = '';

  void createAttendance() async {
    if (attendanceState == RequestState.LOADING) return;

    if (!(await checkLocationPermission())) return;

    errorMessage = '';
    attendanceState = RequestState.LOADING;
    update();

    final position = await Geolocator.getCurrentPosition();
    final body = {
      "name": name,
      "latitude": position.latitude,
      "longitude": position.longitude
    };
    final response = await attendanceRepo.createAttendance(body: body);
    attendanceState = (response?.status ?? 400) == 200
        ? RequestState.SUCCESS
        : RequestState.ERROR;

    if ((response?.status ?? 400) == 200) {
      showSnackbar(
          'Berhasil melakukan absensi di ${response?.data?.locationName}');
    } else {
      showSnackbar(response?.message ?? 'Gagal melakukan absensi');
      errorMessage = response?.message ?? '';
    }

    update();
  }
}
