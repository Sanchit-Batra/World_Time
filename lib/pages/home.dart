import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/standalone.dart' as tz1;
import 'package:flutter_analog_clock/flutter_analog_clock.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    EdgeInsets padding = MediaQuery.of(context).padding;
    double window_height = height - padding.top - padding.bottom;
    // print(window_height);
    var mapArguments = ModalRoute.of(context)?.settings.arguments == null ? <dynamic,dynamic>{} : ModalRoute.of(context)?.settings.arguments as Map;
    data = data.isEmpty ? mapArguments : data;

    tz.initializeTimeZones();
    var detroit = tz1.getLocation(data["url"]);
    var now = tz1.TZDateTime.now(detroit);
    Timer(const Duration(seconds: 1), () {
      setState((){
        data["time"] = data["time"].add(const Duration(seconds: 1));
        // data["time"] = data["time"].add(Duration(seconds: 1));
      });
    });
    // data["time"] = (DateFormat.jm().format(data["time"])).toString();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: data["isday"]
                ? const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                        Color.fromRGBO(57, 59, 245, 1),
                        Color.fromRGBO(62, 103, 238, 1),
                        Color.fromRGBO(84, 171, 230, 1)
                      ])
                : const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                        Colors.black,
                        Color.fromRGBO(22, 63, 198, 1),
                      ])),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: window_height/41.95),
              Text("World Clock",
                  style: TextStyle(color: Colors.white, fontSize: window_height/41.95)),
              SizedBox(height: window_height/20.975),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: window_height/41.95),
                        child: Text(data["location"],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 70,
                              fontWeight: FontWeight.w500,
                              shadows: <Shadow>[
                                Shadow(
                                    offset: Offset(3.0, 6.0),
                                    color:
                                        Color.fromRGBO(0, 0, 0, 0.17647058823529413))
                              ],
                            )),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        dynamic result =
                            await Navigator.pushNamed(context, "/location");
                        if (result != null) {
                          setState(() {
                            data = {
                              "date": result['date'],
                              'time': result['time'],
                              'location': result['location'],
                              'isday': result['isday'] as bool,
                              'url': result['url'],
                            };
                          });
                        }
                      },
                      icon: const Icon(Icons.edit, color: Colors.white,))
                ],
              ),
              SizedBox(height: window_height/41.95),
              Text(data["date"],
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: window_height/41.95,
                      fontWeight: FontWeight.w500)),
              SizedBox(height: window_height/20.975),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: window_height/11.653),
                child: AnalogClock(
                    dateTime: now,
                    hourNumberColor:
                        data["isday"] ? Colors.white : Colors.black,
                    hourHandColor: Colors.white,
                    minuteHandColor: Colors.white,
                    secondHandColor: Colors.red,
                    secondHandLengthFactor: 0.8,
                    centerPointColor: null,
                    hourHandWidthFactor: 0.5,
                    dialColor: Colors.black,
                    hourNumbers: const [
                      '',
                      '',
                      '—',
                      '',
                      '',
                      '|',
                      '',
                      '',
                      '—',
                      '',
                      '',
                      '|'
                    ]),
              ),
              SizedBox(height: window_height/41.95),
                    Text(DateFormat.jm().format(data["time"]),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: window_height/16.78,
                            fontWeight: FontWeight.w500),
                      )

            ],
          ),
        ),
      ),
    );
  }
}
