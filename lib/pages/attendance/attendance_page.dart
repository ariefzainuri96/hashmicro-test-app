import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hashmicro_test_apps/config/enums.dart';
import 'package:hashmicro_test_apps/pages/attendance/attendance_controller.dart';
import 'package:hashmicro_test_apps/pages/history_attendance/history_attendance_page.dart';
import 'package:hashmicro_test_apps/pages/maps/maps_page.dart';
import 'package:hashmicro_test_apps/widgets/custom_button.dart';

class AttendancePage extends StatelessWidget {
  static const routeName = '/attendance-page';

  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AttendanceController>(
        init: AttendanceController(),
        builder: (controller) {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Attendance',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.blueAccent,
                actions: [
                  CustomButton(
                    title: 'History',
                    outlinedColor: Colors.white,
                    onPressed: () =>
                        Get.toNamed(HistoryAttendancePage.routeName),
                    isOutlined: true,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  CustomButton(
                    title: 'Add Location',
                    outlinedColor: Colors.white,
                    onPressed: () => Get.toNamed(MapsPage.routeName),
                    isOutlined: true,
                  ),
                  const SizedBox(
                    width: 16,
                  )
                ],
              ),
              body: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    onChanged: (value) {
                      controller.name = value.trim();
                      controller.update();
                    },
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      hintText: 'Enter your name...',
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
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
                  CustomButton(
                    title: controller.attendanceState == RequestState.LOADING
                        ? 'Loading...'
                        : 'Tap to Attend',
                    onPressed: () => controller.createAttendance(),
                    disable: controller.name.isEmpty ||
                        controller.attendanceState == RequestState.LOADING,
                  ),
                  if (controller.errorMessage.isNotEmpty) ...[
                    Text(
                      controller.errorMessage,
                      style: const TextStyle(
                          fontSize: 16, color: Colors.redAccent),
                    )
                  ]
                ],
              ),
            ),
          );
        });
  }
}
