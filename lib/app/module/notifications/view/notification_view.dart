import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taxi_app/app/module/notifications/controller/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        actions: [
          IconButton(
            icon: Icon(Icons.clear_all),
            onPressed: () {
              controller.clearNotifications();  // Clear notifications
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.notifications.isEmpty) {
          return Center(
            child: Text('No notifications available'),
          );
        }
        return ListView.builder(
          itemCount: controller.notifications.length,
          itemBuilder: (context, index) {
            final notification = controller.notifications[index];
            return ListTile(
              title: Text(notification['title']),
              subtitle: Text(notification['body']),
              trailing: Text(notification['receivedAt']),
            );
          },
        );
      }),
    );
  }
}
