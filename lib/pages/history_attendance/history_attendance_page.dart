import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hashmicro_test_apps/config/enums.dart';
import 'package:hashmicro_test_apps/pages/history_attendance/history_attendance_controller.dart';
import 'package:hashmicro_test_apps/pages/history_attendance/widget/history_attendance_item.dart';
import 'package:hashmicro_test_apps/widgets/custom_button.dart';

class HistoryAttendancePage extends StatelessWidget {
  static const routeName = '/history-attendance-page';
  const HistoryAttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HistoryAttendanceController>(
        init: HistoryAttendanceController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(
                  Icons.arrow_back,
                  size: 24,
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.blueAccent,
              title: const Text(
                'Riwayat Attendance',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: SizedBox(
              width: Get.mediaQuery.size.width,
              height: Get.mediaQuery.size.height,
              child: controller.historyState == RequestState.LOADING
                  ? const Center(child: Text('Loading...'))
                  : controller.historyState == RequestState.ERROR
                      ? Center(
                          child: CustomButton(
                          title: 'Error, tap to reload!',
                          onPressed: () => controller.getHistoryAttendance(),
                        ))
                      : ListView.separated(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          shrinkWrap: true,
                          itemBuilder: (_, index) => HistoryAttendanceItem(
                              data: controller.historyAttendanceList[index]),
                          separatorBuilder: (_, __) => const Divider(
                            height: 6,
                            color: Colors.transparent,
                          ),
                          itemCount: controller.historyAttendanceList.length,
                        ),
            ),
          );
        });
  }
}
