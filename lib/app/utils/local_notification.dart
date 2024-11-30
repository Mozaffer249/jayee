// import 'dart:convert';
// import 'dart:developer';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// void myLocalNotification(
//     {required String title,
//     required String body,
//     required Map<String, dynamic> payload}) async {
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//
//   const AndroidInitializationSettings initializationSettingsAndroid =
//       AndroidInitializationSettings("@mipmap/launcher_icon");
//
//   final IOSInitializationSettings initializationSettingsIOS =
//       IOSInitializationSettings(
//     requestSoundPermission: false,
//     requestBadgePermission: false,
//     requestAlertPermission: false,
//   );
//   final MacOSInitializationSettings initializationSettingsMacOS =
//       MacOSInitializationSettings(
//           requestAlertPermission: false,
//           requestBadgePermission: false,
//           requestSoundPermission: false);
//   final InitializationSettings initializationSettings = InitializationSettings(
//       android: initializationSettingsAndroid,
//       iOS: initializationSettingsIOS,
//       macOS: initializationSettingsMacOS);
//
//   await flutterLocalNotificationsPlugin.initialize(
//     initializationSettings,
//     onSelectNotification: selectNotification,
//   );
//
//   AndroidNotificationDetails notificationAndroidSpecifics =
//       AndroidNotificationDetails(
//     "3",
//     "groupChannelName",
//     playSound: true,
//     sound: RawResourceAndroidNotificationSound('@raw/uber_driver'),
//     importance: Importance.max,
//     priority: Priority.high,
//     groupKey: "100",
//   );
//
//   NotificationDetails notificationPlatformSpecifics =
//       NotificationDetails(android: notificationAndroidSpecifics);
//   await flutterLocalNotificationsPlugin.show(
//     3,
//     title,
//     body,
//     notificationPlatformSpecifics,
//     payload: json.encode(payload),
//   );
// }
//
// void selectNotification(String? payload) async {
//   if (payload != null) {
//     debugPrint('notification payload: $payload');
//   }
//   Map<String, dynamic> jsonPayload = json.decode(payload!);
//   log('Decoded payload $jsonPayload');
//   handleNotification(jsonPayload);
// }
//
// void handleNotification(Map<String, dynamic> jsonPayload) async {
//   try {
//     // TODO: Implement on press to notification
//   } catch (e) {
//     log("ex on notification pressed: $e");
//   }
// }
