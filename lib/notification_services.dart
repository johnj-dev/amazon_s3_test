

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {

  void initNotification() async {
    FlutterLocalNotificationsPlugin flp = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = IOSInitializationSettings();
    var initSetttings = InitializationSettings(android: android, iOS: iOS);

    flp.initialize(initSetttings, onSelectNotification: notificationSelected);
  }

  Future notificationSelected(String payload) async {
    // Navigator.push(context, MaterialPageRoute(builder: (context) => OrderTracker()));
  }
}