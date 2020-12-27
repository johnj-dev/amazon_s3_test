import 'dart:io';

import 'package:amazon_s3_test/order_tracker.dart';
import 'package:flutter/material.dart';
import 'package:amazon_s3_test/policy_v3.dart';

void main() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('testing'),
      ),
      body: Column(
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
        ],
      ),
    );
  }
}

