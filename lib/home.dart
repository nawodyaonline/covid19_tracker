import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _homeState();
  }
}

class _homeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text('Covid-19 \n Tracker'),
          ),
          Expanded(
            child: Image.asset('flag.jpg'),
          ),
        ],
      ),
    );
  }
}
