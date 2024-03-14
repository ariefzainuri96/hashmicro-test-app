import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:hashmicro_test_apps/pages/maps/maps_controller.dart';
import 'package:hashmicro_test_apps/widgets/custom_button.dart';
import 'package:latlong2/latlong.dart';

class MapsPage extends StatelessWidget {
  static const routeName = '/maps-page';
  const MapsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: GetBuilder<MapsController>(
          init: MapsController(),
          builder: (controller) {
            return Stack(
              children: [
                SizedBox(
                  width: Get.mediaQuery.size.width,
                  height: Get.mediaQuery.size.height,
                  child: FlutterMap(
                    mapController: controller.mapController,
                    options: MapOptions(
                        initialCenter: const LatLng(-6.179649, 106.824784),
                        initialZoom: 15,
                        minZoom: 5,
                        onTap: (position, latLng) {
                          controller.tappedLatLng = latLng;
                          controller.update();
                        }),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.falcon_kalbe_app',
                        subdomains: const ['a', 'b', 'c'],
                        minZoom: 5,
                        maxZoom: 30,
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: controller.currentPosition,
                            width: 48,
                            height: 48,
                            child: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      const Color(0xffF1F7E5).withOpacity(0.49),
                                  border: Border.all(
                                      color: Colors.blueAccent, width: 0.84)),
                              alignment: Alignment.center,
                              child: Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.white, width: 1)),
                              ),
                            ),
                          ),
                          if (controller.tappedLatLng != null) ...[
                            Marker(
                              point: controller.tappedLatLng!,
                              width: 120,
                              height: 120,
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.place,
                                    color: Colors.blueAccent,
                                    size: 40,
                                  ),
                                ],
                              ),
                            ),
                          ],
                          ...controller.locationList.map((location) {
                            return Marker(
                              point: LatLng(location.latitude ?? 0.0,
                                  location.longitude ?? 0),
                              width: 48,
                              height: 48,
                              child: Tooltip(
                                preferBelow: false,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6)),
                                triggerMode: TooltipTriggerMode.tap,
                                message: location.name ?? '',
                                textStyle: const TextStyle(fontSize: 16),
                                child: const Icon(
                                  Icons.place,
                                  color: Colors.redAccent,
                                  size: 40,
                                ),
                              ),
                            );
                          }),
                        ],
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: Get.mediaQuery.padding.top + 16,
                  left: 16,
                  child: GestureDetector(
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.arrow_back,
                        size: 24,
                      ),
                    ),
                    onTap: () => Get.back(),
                  ),
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  left: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        child: Container(
                          width: 48,
                          height: 48,
                          margin: const EdgeInsets.only(right: 16, bottom: 16),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.refresh,
                            size: 24,
                          ),
                        ),
                        onTap: () => controller.getLocation(),
                      ),
                      GestureDetector(
                        child: Container(
                          width: 48,
                          height: 48,
                          margin: const EdgeInsets.only(right: 16, bottom: 16),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          alignment: Alignment.center,
                          child: controller.isGetCurrentPositionLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.blueAccent,
                                  ),
                                )
                              : const Icon(
                                  Icons.place_rounded,
                                  size: 24,
                                ),
                        ),
                        onTap: () => controller.determinePosition(),
                      ),
                      TextFormField(
                        controller: controller.locationNameController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        onChanged: (value) {
                          controller.locationName = value.trim();
                          controller.update();
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          hintText: 'Enter location name information...',
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                                color: Color(0xffCBCCCD), width: 1),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        width: Get.mediaQuery.size.width,
                        child: CustomButton(
                          disable: controller.tappedLatLng == null ||
                              controller.locationName.isEmpty,
                          title: 'Add Location',
                          onPressed: () => controller.addLocation(),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
