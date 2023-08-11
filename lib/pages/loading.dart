import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Future<WorldTime> setupWorldTime() async {
    WorldTime instance = WorldTime(location: "Kolkata", url: "Asia/Kolkata", );
    await instance.getTime();
    return instance;
  }

  void necessaryFunc() async {
    WorldTime some = await setupWorldTime();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, "/home", arguments: {
      "time": some.time,
      "location": some.location,
      "date": some.date,
      "isday" : some.isDay,
      "url" : some.url
    });
  }

  @override
  void initState() {
    super.initState();
    necessaryFunc();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SpinKitRing(
            color: Colors.black,
            size: 150.0,),
        );
  }
}
