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

//this is the name given to the background fetch
const simplePeriodicTask = "testTask";
// flutter local notification setup
void showNotification(v, flp) async {
  var android = AndroidNotificationDetails(
      'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
      priority: Priority.high, importance: Importance.max);
  var iOS = IOSNotificationDetails();
  var platform = NotificationDetails(android: android, iOS: iOS);
  await flp.show(0, 'VeMoBro', '$v', platform,
      payload: 'VIS \n $v');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Workmanager.initialize(callbackDispatcher, isInDebugMode: true); //to true if still in testing lev turn it to false whenever you are launching the app
  await Workmanager.registerPeriodicTask("uniqueName", simplePeriodicTask,
      existingWorkPolicy: ExistingWorkPolicy.replace,
      frequency: Duration(minutes: 15),//when should it check the link
      initialDelay: Duration(seconds: 5),//duration before showing the notification
      constraints: Constraints(
        networkType: NetworkType.connected,
      ));
  runApp(MyApp());
}

void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) async {

    FlutterLocalNotificationsPlugin flp = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = IOSInitializationSettings();
    var initSetttings = InitializationSettings(android: android, iOS: iOS);
    flp.initialize(initSetttings);
    print(task);
    print(inputData);

    showNotification('TEST THIS NOTIFICATION', flp);

    return Future.value(true);
  });
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHome(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          ],
        ),
      ),
    );
  }
}

