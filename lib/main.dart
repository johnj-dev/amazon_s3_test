import 'dart:io';

import 'package:amazon_s3_test/order_tracker.dart';
import 'package:amazon_s3_test/performance_buyer.dart';
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
        ],
      ),
    );
  }
}

