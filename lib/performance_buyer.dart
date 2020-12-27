import 'package:flutter/material.dart';

class PerformanceBuyer extends StatefulWidget {
  @override
  _PerformanceBuyerState createState() => _PerformanceBuyerState();
}

class _PerformanceBuyerState extends State<PerformanceBuyer> {
  int progress;

  @override
  void initState() {
    // TODO: implement initState
    progress = 74;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Performance'),
      ),
      body: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Almost there! Just gain a few more points!')),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Try harder to boost your shopping performance')),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text('$progress%')),
                  LinearProgressIndicator(
                    backgroundColor: Colors.greenAccent,
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
                    value: progress != 0 ? progress/100 : 0,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Overall Shopping Performance',
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Successful Orders'),
                      Expanded(
                        child: Tooltip(
                          // waitDuration: Duration(seconds: 1),
                          showDuration: Duration(seconds: 2),
                          padding: EdgeInsets.all(5),
                          height: 35,
                          textStyle: TextStyle(
                              fontSize: 15, color: Colors.white, fontWeight: FontWeight.normal),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10), color: Colors.green),
                          message: 'Tool tip here=================',
                          child: IconButton(
                            icon: Icon(Icons.info),
                            onPressed: () {
                              /* your code */
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('3/12')
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Total Completed Orders')
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Product Reviews'),
                      Expanded(
                        child: Tooltip(
                          // waitDuration: Duration(seconds: 1),
                          showDuration: Duration(seconds: 2),
                          padding: EdgeInsets.all(5),
                          height: 35,
                          textStyle: TextStyle(
                              fontSize: 15, color: Colors.white, fontWeight: FontWeight.normal),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10), color: Colors.green),
                          message: 'Tool tip here=================',
                          child: IconButton(
                            icon: Icon(Icons.info),
                            onPressed: () {
                              /* your code */
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total Reviews'),
                          Text('1')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Flagged Reviews'),
                          Text('0')
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Delivery Acceptance'),
                      Expanded(
                        child: Tooltip(
                          // waitDuration: Duration(seconds: 1),
                          showDuration: Duration(seconds: 2),
                          padding: EdgeInsets.all(5),
                          height: 35,
                          textStyle: TextStyle(
                              fontSize: 15, color: Colors.white, fontWeight: FontWeight.normal),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10), color: Colors.green),
                          message: 'Tool tip here=================',
                          child: IconButton(
                            icon: Icon(Icons.info),
                            onPressed: () {
                              /* your code */
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text('3')
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Total accepted orders on first delivery')
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Cancellation'),
                      Expanded(
                        child: Tooltip(
                          // waitDuration: Duration(seconds: 1),
                          showDuration: Duration(seconds: 2),
                          padding: EdgeInsets.all(5),
                          height: 35,
                          textStyle: TextStyle(
                              fontSize: 15, color: Colors.white, fontWeight: FontWeight.normal),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10), color: Colors.green),
                          message: 'Tool tip here=================',
                          child: IconButton(
                            icon: Icon(Icons.info),
                            onPressed: () {
                              /* your code */
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text('Cancelled orders before processing')),
                          Text('1')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text('Cancelled order after processing')),
                          Text('0')
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
