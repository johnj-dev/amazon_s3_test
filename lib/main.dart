import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'package:amazon_s3_test/activities_buyer.dart';
import 'package:amazon_s3_test/order_tracker.dart';
import 'package:amazon_s3_test/performance_buyer.dart';
import 'package:flutter/material.dart';
import 'package:amazon_s3_test/policy_v3.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:amazon_s3_test/constants.dart';



var initRoute = '/';
var flp;

void showNotification(v, flp) async {
  var android = AndroidNotificationDetails(
      'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
      priority: Priority.high, importance: Importance.max);
  var iOS = IOSNotificationDetails();
  var platform = NotificationDetails(android: android, iOS: iOS);
  await flp.show(0, 'VeMoBro', '$v', platform,
      payload: 'VIS \n $v');
}

Future notificationSelected(String payload) async {
  print(payload);
  initRoute = '/Order';
  print(initRoute);
  //Navigator.push(key.currentContext, MaterialPageRoute(builder: (context) => OrderTracker()));
}

FlutterLocalNotificationsPlugin initNotification() {
  FlutterLocalNotificationsPlugin flp = FlutterLocalNotificationsPlugin();
  var android = AndroidInitializationSettings('@mipmap/ic_launcher');
  var iOS = IOSInitializationSettings();
  var initSetttings = InitializationSettings(android: android, iOS: iOS);

  flp.initialize(initSetttings, onSelectNotification: notificationSelected);
  return flp;
}

void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) async {

    flp = initNotification();
    // flp.initialize(initSetttings);
    showNotification('TEST THIS NOTIFICATION', flp);

    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: MyHome(),
      initialRoute: initRoute,
      routes: {
        '/': (context) => MyHome(),
        '/Order': (context) => OrderTracker(),
      },
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  File file;

  Future<void> loadImage() async {
    var getFile = await Policy().getPicture();
    // setState(() {
    //   file = getFile;
    // });
  }



  void askAQuestion() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('How may I help you?'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 4,
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                child: Text('Submit'),
                onPressed: (){}
              ),
            ],
          ),
        );
      }
    );
  }

  void initApp() async {
    await Workmanager.initialize(callbackDispatcher, isInDebugMode: true); //to true if still in testing lev turn it to false whenever you are launching the app
    await Workmanager.registerPeriodicTask("firstNotif", simplePeriodicTask,
      existingWorkPolicy: ExistingWorkPolicy.replace,
      initialDelay: Duration(seconds: 5),//duration before showing the notification
      constraints: Constraints(
        networkType: NetworkType.connected,
      ));
  }

  @override
  void initState() {
    // TODO: implement initState
    initApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text('testing'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            file != null ? Image.file(file) : Text('File not loaded'),
            RaisedButton(
              child: Text('Load image'),
              onPressed: () {
                loadImage();
              }
            ),
            RaisedButton(
              child: Text('Order Tracker'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => OrderTracker()));
              }
            ),
            RaisedButton(
              child: Text('Ask a Question'),
              onPressed: () {
                askAQuestion();
              }
            ),
            RaisedButton(
              child: Text('Performance'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => PerformanceBuyer()));
              }
            ),
            RaisedButton(
              child: Text('Activities'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => Activities()));
              }
            ),

            RaisedButton(
                child: Text('Show Notification'),
                onPressed: () {
                  // FlutterLocalNotificationsPlugin flp = FlutterLocalNotificationsPlugin();
                  // var android = AndroidInitializationSettings('@mipmap/ic_launcher');
                  // var iOS = IOSInitializationSettings();
                  // var initSetttings = InitializationSettings(android: android, iOS: iOS);
                  //
                  // flp.initialize(initSetttings, onSelectNotification: notificationSelected);
                  showNotification('TEST THIS NOTIFICATION', flp);
                }
            )
          ],
        ),
      ),
    );
  }
}

