import 'package:get/get.dart';
import 'package:hashmicro_test_apps/config/enums.dart';
import 'package:hashmicro_test_apps/pages/history_attendance/model/attendance_history_response.dart';
import 'package:hashmicro_test_apps/repository/attendance_repository.dart';

class HistoryAttendanceController extends GetxController {
  final attendanceRepo = AttendanceRepositoryImpl();

  RequestState historyState = RequestState.IDLE;
  List<AttendanceHistoryObj> historyAttendanceList = [];

  void getHistoryAttendance() async {
    if (historyState == RequestState.LOADING) return;

    historyState = RequestState.LOADING;
    update();
    final response = await attendanceRepo.getAttendanceHistory();
    historyState = (response?.status ?? 400) == 200
        ? RequestState.SUCCESS
        : RequestState.ERROR;

    historyAttendanceList.assignAll(response?.data ?? []);
    update();
  }

  @override
  void onInit() {
    getHistoryAttendance();

    super.onInit();
  }
}
