import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

void showDialogLoading({required bool dismissable, String? text}) {
  Get.dialog(
    PopScope(
      canPop: dismissable,
      onPopInvoked: (value) {
        if (value) return;

        Future.value(dismissable);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Colors.blueAccent,
                    ),
                  ),
                  if (text != null) ...[
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      text,
                      style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xff000000),
                          decoration: TextDecoration.none),
                    )
                  ]
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    barrierDismissible: false,
  );
}

void closeDialogLoading({bool useSimpleGetBack = false}) {
  if (Get.isDialogOpen ?? false) {
    Get.until((route) => !(Get.isDialogOpen ?? true));
  }
}

void showSnackbar(String message,
    {String? title,
    SnackPosition snackPosition = SnackPosition.TOP,
    Duration? duration,
    Color? backgroundColor,
    Function(GetSnackBar)? onTap,
    EdgeInsets? margin}) {
  if (Get.isSnackbarOpen) Get.back();

  GetSnackBar(
    titleText: title == null
        ? const SizedBox()
        : Text(
            title,
            style: const TextStyle(fontSize: 14, color: Colors.white),
          ),
    messageText: Container(
      transform: Matrix4.translationValues(0.0, title == null ? -1.5 : 0, 0.0),
      child: Text(
        message,
        style: const TextStyle(fontSize: 14, color: Colors.white),
      ),
    ),
    title: '',
    onTap: onTap,
    backgroundColor: Colors.black87,
    snackPosition: snackPosition,
    message: '',
    duration: duration ?? const Duration(seconds: 5),
    margin: margin ?? const EdgeInsets.all(8),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    borderRadius: 6,
  ).show();
}

Future<bool> checkLocationPermission() async {
  LocationPermission permission;

  if (!(await Geolocator.isLocationServiceEnabled())) {
    showSnackbar('Location services are disabled.');
    return false;
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      showSnackbar('Location permissions are denied');
      return false;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    showSnackbar(
        'Location permissions are permanently denied, we cannot request permissions.');
    return false;
  }

  return true;
}
