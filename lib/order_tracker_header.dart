import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';

class OrderTrackerHeader extends StatefulWidget {
  @override
  _OrderTrackerHeaderState createState() => _OrderTrackerHeaderState();
}

class _OrderTrackerHeaderState extends State<OrderTrackerHeader> {

  Widget _containerIcon(Icon icon, bool status) {
    return Expanded(
      child: Container(
        // margin: EdgeInsets.only(top: 16),
        child: icon,
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 1.5, color: Colors.green),
        ),
      ),
    );
  }

  Widget _dashHeader() {
    return Expanded(
      child: Dash(
        direction: Axis.horizontal,
        length: 15,
        dashLength: 30,
        dashThickness: 3,
        dashColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Tracker Header'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  _containerIcon(Icon(Icons.all_inbox_rounded), true),
                  _dashHeader(),
                  _containerIcon(Icon(Icons.rv_hookup_rounded), true),
                  _dashHeader(),
                  _containerIcon(Icon(Icons.delivery_dining), true),
                  _dashHeader(),
                  _containerIcon(Icon(Icons.forward), true),
                  _dashHeader(),
                  _containerIcon(Icon(Icons.check), true),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
