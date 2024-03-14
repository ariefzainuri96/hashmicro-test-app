import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hashmicro_test_apps/pages/attendance/attendance_page.dart';
import 'package:hashmicro_test_apps/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hashmicro Test',
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: AttendancePage.routeName,
      getPages: Routes.getPages(),
    );
  }
}
