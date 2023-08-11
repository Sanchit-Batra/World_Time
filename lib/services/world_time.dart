import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String url;
  DateTime time = DateTime(1993);
  String country = "";
  String date = "";
  bool isDay = true;

  WorldTime({ required this.location, required this.url});

  Future<void> getTime() async {
    // getting info and decoding it
    Response response = await get(
        Uri.parse("http://worldtimeapi.org/api/timezone/$url"));
    Map use = jsonDecode(response.body);

    // extracting usefuls from it
    String datetime = use['datetime'];
    int offsetHours = int.parse(use['utc_offset'].substring(1, 3));
    int offsetMinutes = int.parse(use['utc_offset'].substring(4, 6));

    // converting into readable format
    DateTime now = DateTime.parse(datetime);
    time = now.add(Duration(hours: offsetHours, minutes: offsetMinutes));
    date = (DateFormat("E d MMM yyyy").format(now));
    int railformat = int.parse(now.toString().substring(11, 13));
    isDay = 20 > railformat ? railformat > 6 : false;
    print(railformat);
  }
}