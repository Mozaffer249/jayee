import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taxi_app/app.dart';
import 'package:taxi_app/app/data/common/common_variables.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();

   await setupNotification();
  String? langCode;
  if(CommonVariables.langCode.read(LANG_CODE) == null)
    {
      CommonVariables.langCode.write(LANG_CODE, "ar"  );
      langCode= CommonVariables.langCode.read(LANG_CODE);
    }
  else   langCode = CommonVariables.langCode.read(LANG_CODE);
  timeago.setLocaleMessages(langCode!, timeago.ArMessages());
  //! Set base url to production server
  CommonVariables.userData.write(BASE_URL, 'https://api.faster.sa:5000/api/');

  runApp(
    App(langCode: langCode),
  );
  // runApp(
  //   DevicePreview(
  //     enabled:  true,
  //     tools: const [
  //       ...DevicePreview.defaultTools,
  //     ],
  //     builder: (context) => App(langCode: langCode!),
  //   ),
  // );
}


FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> _onBackgroundHandler(RemoteMessage message) async {
  log('On background message: ${message.data}');
  saveNotification(message);

}

Future<void> setupNotification() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  // Local notifications initialization
  const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  final DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
    onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {
      // Handle iOS foreground notification
      print("iOS Local notification received");
    },
  );
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
      // Handle when user taps on notification
      print("Notification tapped: ${notificationResponse.payload}");
    },
  );

  // Request permission for iOS
  if (Platform.isIOS) {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    log('User granted permission: ${settings.authorizationStatus}');
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  // Handle foreground messages and show local notification
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    log('On foreground message: ${message.notification?.title},body: ${message.notification?.body}');
    log('On foreground message data: ${message.data} ');
     saveNotification(message);

    showLocalNotification(message.notification?.title, message.notification?.body);
  });
  // Background message handling
  FirebaseMessaging.onBackgroundMessage(_onBackgroundHandler);
  // Handle notification taps (when app is opened from background or terminated state)
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    log('Notification clicked and app opened: ${message.notification?.title}');
    // Handle navigation or actions here
  });
  // Handle when the app is launched from a terminated state via notification
  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
    if (message != null) {
      log('App launched from terminated state via notification: ${message.notification?.title}');
      // Handle navigation or actions here
    }
  });
}

void showLocalNotification(String? title, String? body) async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'channel_id',
    'channel_name',
    channelDescription: 'channel_description',
    importance: Importance.max,
    priority: Priority.high,
  );
  const NotificationDetails platformDetails = NotificationDetails(
    android: androidDetails,
    iOS: DarwinNotificationDetails(),

  );
  await flutterLocalNotificationsPlugin.show(
    0, // Notification ID
    title ?? 'No Title',
    body ?? 'No Body',
    platformDetails,
    payload: 'Notification Payload', // Custom payload
  );
}
void saveNotification(RemoteMessage message) {
  final box = GetStorage();

  // Get the current notifications list or initialize an empty list
  List<dynamic> notifications = box.read('notifications') ?? [];

  // Create a notification map to store
  Map<String, dynamic> notification = {
    'title': message.notification?.title ?? 'No Title',
    'body': message.notification?.body ?? 'No Body',
    'data': message.data,
    'receivedAt': DateTime.now().toString(),
  };

  // Add the new notification to the list
  notifications.add(notification);

  // Save the updated list back to GetStorage
  box.write('notifications', notifications);
  // NotificationController controller = Get.find();
  // controller.loadNotifications();  // Reload the notifications
}




