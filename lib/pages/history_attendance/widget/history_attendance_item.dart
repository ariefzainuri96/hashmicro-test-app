import 'package:flutter/material.dart';
import 'package:hashmicro_test_apps/pages/history_attendance/model/attendance_history_response.dart';

class HistoryAttendanceItem extends StatelessWidget {
  final AttendanceHistoryObj data;

  const HistoryAttendanceItem({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), color: Colors.black12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              'Berhasil absensi di ${data.locationName ?? ''} pada ${(data.createdAt ?? DateTime.now()).toLocal()}'),
          if (data.distance != null) ...[
            const SizedBox(
              height: 4,
            ),
            Text('Berada pada jarak ${data.distance ?? 0}m dari lokasi absensi')
          ]
        ],
      ),
    );
  }
}
