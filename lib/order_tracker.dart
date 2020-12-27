import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';

class OrderTracker extends StatefulWidget {
  @override
  _OrderTrackerState createState() => _OrderTrackerState();
}

class _OrderTrackerState extends State<OrderTracker> {
  
  List<Widget> content = [];
  int progress;

  //Buyer Id = 41; Order Number = VMB2012200146 - Test it with this

  Widget _bullets(index) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: Visibility(
            visible: index.isEven,
            child: ListTile(
              title: Text(
                'Order Received',
                textAlign: TextAlign.end,
              ),
              subtitle: Text(
                'date',
                textAlign: TextAlign.end,
              ),
            ),
          ),
        ),
        _circleIndicator(index),
        Expanded(
          child: Visibility(
            visible: index.isOdd,
            child: ListTile(
              title: Text('Order Received'),
              subtitle: Text('date'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _circleIndicator(index) {
    return Column(
      children: [
        Visibility(
          maintainAnimation: true,
          maintainState: true,
          maintainSize: true,
          visible: index != 0,
          child: Dash(
            direction: Axis.vertical,
            length: 15,
            dashLength: 30,
            dashThickness: 3,
            dashColor: Colors.green,
          ),
        ),
        Container(
          // margin: EdgeInsets.only(top: 16),
          height: 25,
          width: 25,
          decoration: BoxDecoration(
              color: index == 4 ? Colors.green : Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(width: 1.5, color: Colors.green),
          ),
        ),
        Visibility(
          maintainAnimation: true,
          maintainState: true,
          maintainSize: true,
          visible: index < 4 ,
          child: Dash(
            direction: Axis.vertical,
            length: 15,
            dashLength: 30,
            dashThickness: 3,
            dashColor: Colors.green,
          ),
        )
      ],
    );
  }

  Widget _dashTracker() {
    return Dash(
      direction: Axis.vertical,
      length: 15,
      dashLength: 7.5,
      dashThickness: 3,
      dashColor: Colors.green,
    );
  }

  Widget _containerIcon(icon, bool status) {
    return Expanded(
      child: Container(
        // margin: EdgeInsets.only(top: 16),
        child: Icon(
          icon,
          color: status ? Colors.white : Colors.black,
        ),
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: status ? Colors.green : Colors.grey,
          shape: BoxShape.circle,
          border: Border.all(
            width: 1.5,
            color: status ? Colors.green : Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _dashHeader(bool status) {
    return Expanded(
      child: Dash(
        direction: Axis.horizontal,
        length: 19.5,
        dashLength: 39,
        dashThickness: 3,
        dashColor: status ? Colors.green : Colors.grey,
      ),
    );
  }

  void initData() {
    for(var count = 0; count < 5; count++) {
      if(count > 0) {
        content.add(_dashTracker());
      }
      content.add(_bullets(count));
    }

    progress = 50;
  }

  @override
  void initState() {
    // TODO: implement initState
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Tracker'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        _containerIcon(Icons.all_inbox_rounded, progress > 0),
                        _dashHeader(progress > 24),
                        _containerIcon(Icons.rv_hookup_rounded, progress > 24),
                        _dashHeader(progress > 49),
                        _containerIcon(Icons.delivery_dining, progress > 49),
                        _dashHeader(progress > 74),
                        _containerIcon(Icons.forward, progress > 74),
                        _dashHeader(progress == 100),
                        _containerIcon(Icons.check, progress == 100),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Center(
              child: Column(
                children: content
              ),
            ),
          ],
        ),
      ),
    );
  }
}
