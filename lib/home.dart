import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _homeState();
  }
}

// ignore: camel_case_types
class _homeState extends State<Home> {
  String dateTime;
  int totalCases = 0;
  int totalRecover = 0;
  int totalDead = 0;
  int totalActive = 0;

  Map data;
  List userData;

  String url = 'https://www.hpb.health.gov.lk/api/get-current-statistical';
  // ignore: missing_return
  Future getData() async {
    http.Response response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    data = json.decode(response.body);
    setState(() {
      dateTime = data["data"]['update_date_time'];
      totalRecover = data["data"]["local_recovered"];
      totalDead = data["data"]["local_deaths"];
      totalActive = data["data"]["local_active_cases"];
      totalCases = data["data"]["local_total_cases"];
    });

    // debugPrint(dateTime.toString());
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20.0, left: 8, right: 8, bottom: 2),
          child: ListView(
            children: <Widget>[
              // Top Row Bar with title & flag
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Covid-19 \n Tracker',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 40),
                      ),
                    ),
                    Container(
                      child: Image.asset(
                        'images/flag.jpg',
                        width: 150,
                      ),
                    ),
                  ],
                ),
              ),

              // TextArea
              Text(
                'Live Situational Dashboard',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Last Update: $dateTime',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 10,
              ),

              // Main Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 3, right: 3),
                  child: Column(children: <Widget>[
                    Text(
                      'Total',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    // first Cases Row card uses full Width
                    Card(
                      shadowColor: Colors.green,
                      elevation: 15,
                      color: Colors.green[50],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Total Recovered Cases',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.green[500],
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    totalRecover.toString(),
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                  child: Image.asset(
                                'images/recoverd.png',
                                width: 100,
                              )),
                            ]),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          child: Card(
                            color: Colors.red[100],
                            shadowColor: Colors.red,
                            elevation: 15,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  SizedBox(
                                    height: 70,
                                    child: Image.asset(
                                      'images/death.png',
                                      width: 100,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Deaths',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.red[800],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    totalDead.toString(),
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            shadowColor: Colors.red[800],
                            elevation: 15,
                            color: Colors.red[50],
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  SizedBox(
                                    height: 70,
                                    child: Image.asset(
                                      'images/active.png',
                                      width: 100,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Active Cases',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.red[900],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    totalActive.toString(),
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Card(
                      shadowColor: Colors.orange[800],
                      elevation: 15,
                      color: Colors.orange[50],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Total Confirmed Cases',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.orange[500],
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    totalCases.toString(),
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                    child: Image.asset(
                                  'images/total.png',
                                  width: 70,
                                )),
                              ),
                            ]),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Copyright ©  👦 Nawodya Jayalath',
                        style: TextStyle(
                          color: Colors.blueGrey[700],
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
