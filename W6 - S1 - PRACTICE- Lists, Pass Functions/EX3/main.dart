import 'package:flutter/material.dart';
import 'package:new_flutter_app/W6_S2/EX3/screen/welcome.dart';
import 'package:new_flutter_app/W6_S2/EX3/screen/temperature.dart';

class TemperatureApp extends StatefulWidget {
  const TemperatureApp({super.key});

  @override
  State<TemperatureApp> createState() {
    return _TemperatureAppState();
  }
}

class _TemperatureAppState extends State<TemperatureApp> {

  bool showWelcomeScreen = true;

  void switchScreen(){
    setState(() {
      showWelcomeScreen = !showWelcomeScreen;
    });
  }

  @override
  Widget build(context) {

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff16C062),
                Color(0xff00BCDC),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child:
          showWelcomeScreen ? Welcome(onStartPressed: switchScreen): Temperature(),
        ),
      ),
    );
  }
}

void main() {
  runApp(const TemperatureApp());
}