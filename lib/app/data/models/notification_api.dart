// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:rxdart/rxdart.dart';
//
// class NotificationApi {
//   static final notification = FlutterLocalNotificationsPlugin();
//   static final  Onnotification = BehaviorSubject<String?> ();
//
//   static Future<void> showNotification({
//     int id = 0,
//     String? title,
//     String? body,
//     String? payload,
//     Future<dynamic> Function(String?)? onSelectNotification,
//   }) async {
//     final androidInitializationSettings = AndroidInitializationSettings('@mipmap/launcher_icon');
//     final iosInitializationSettings = IOSInitializationSettings();
//     final initializationSettings = InitializationSettings(android: androidInitializationSettings, iOS: iosInitializationSettings,);
//
//     await notification.initialize(initializationSettings, onSelectNotification: onSelectNotification,);
//     await notification.show(
//       id,
//       title,
//       body,
//       await _notificationDetails(),
//       payload: payload,
//     );
//   }
//
//
//
//   static Future _notificationDetails() async {
//     return NotificationDetails(
//         android: AndroidNotificationDetails(
//           "channel Id",
//           "channel Name",
//           "channel Description",
//           importance: Importance.max,
//           priority: Priority.high,
//           icon: '@mipmap/launcher_icon',
//         ),
//         iOS: IOSNotificationDetails());
//   }
// }
