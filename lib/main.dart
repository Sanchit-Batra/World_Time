import 'package:flutter/material.dart';
import 'package:world_time/pages/home.dart';
import 'package:world_time/pages/loading.dart';
import 'package:world_time/pages/location.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/":(context)=>const Loading(),
        "/location":(context)=>const ChooseLocation(),
        "/home":(context)=>const Home(),
      },
    )
  );
}

