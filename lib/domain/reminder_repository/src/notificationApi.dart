import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();

  Future initialize()async{
     FlutterLocalNotificationsPlugin flutterLocalNotificationPlugin= 
     FlutterLocalNotificationsPlugin();
     AndroidInitializationSettings androidInitializationSettings= AndroidInitializationSettings("ic_launcher");
     IOSInitializationSettings iosInitializationSettings=IOSInitializationSettings();
     final InitializationSettings initializationSettings= InitializationSettings(iOS: iosInitializationSettings,
     android: androidInitializationSettings);

     await flutterLocalNotificationPlugin.initialize(initializationSettings);
  }

  static Future _notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails('channel id', 'channel name',
          importance: Importance.max),
      iOS: IOSNotificationDetails(),
    );
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      {
        _notifications.show(id, title, body, await _notificationDetails(),
            payload: "dsd")
      };
}
