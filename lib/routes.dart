import 'package:get/get.dart';
import 'package:hashmicro_test_apps/pages/attendance/attendance_page.dart';
import 'package:hashmicro_test_apps/pages/history_attendance/history_attendance_page.dart';
import 'package:hashmicro_test_apps/pages/maps/maps_page.dart';

class Routes {
  static List<GetPage<dynamic>>? getPages() {
    return [
      GetPage(
        name: AttendancePage.routeName,
        page: () => const AttendancePage(),
      ),
      GetPage(
        name: MapsPage.routeName,
        page: () => const MapsPage(),
      ),
      GetPage(
        name: HistoryAttendancePage.routeName,
        page: () => const HistoryAttendancePage(),
      ),
    ];
  }
}
