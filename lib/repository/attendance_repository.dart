import 'package:hashmicro_test_apps/config/dio_config.dart';
import 'package:hashmicro_test_apps/pages/attendance/model/attendance_response.dart';
import 'package:hashmicro_test_apps/pages/history_attendance/model/attendance_history_response.dart';

abstract class AttendanceRepository {
  Future<AttendanceResponse?> createAttendance({required dynamic body});
  Future<AttendanceHistoryResponse?> getAttendanceHistory();
}

class AttendanceRepositoryImpl extends AttendanceRepository {
  @override
  Future<AttendanceResponse?> createAttendance({required dynamic body}) async {
    final dio = await DioConfig.dioInstance();

    try {
      final response = await dio.post('/api/attendance', data: body);
      return AttendanceResponse.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<AttendanceHistoryResponse?> getAttendanceHistory() async {
    final dio = await DioConfig.dioInstance();

    try {
      final response = await dio.get('/api/attendance');
      return AttendanceHistoryResponse.fromJson(response.data);
    } catch (e) {
      return null;
    }
  }
}
