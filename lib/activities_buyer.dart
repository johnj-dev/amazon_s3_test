import 'package:flutter/material.dart';

class Activities extends StatefulWidget {
  @override
  _ActivitiesState createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activities'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search'
                  ),
                ),
              ),
              Icon(Icons.search)
            ],
          ),
        ),
      ),
      // TODO : this should be Paged List View
      body: ListView.builder(
        itemCount: 50,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('You have view this product'),
            trailing: Text('Dec. 27, 2020 02:46 PM'),
          );
        }),
    );
  }
}
