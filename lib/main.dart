import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gif_view/gif_view.dart';
import 'package:just_audio/just_audio.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:timer_count_down/timer_count_down.dart';

var destination = DateTime(2023, DateTime.august, 27, 6);
// var start = DateTime(2023, DateTime.august, 27, 5, 59, 50);
var start = DateTime(2023, DateTime.august, 22, 12, 0, 0);
// var now = DateTime(2023, DateTime.august, 27, 5, 59, 59);
var now = DateTime.now();

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AssetImage arby;
  @override
  void initState() {
    super.initState();
    arby = AssetImage("assets/arby.gif");
  }

  @override
  Widget build(BuildContext context) {
    return Countdown(
      seconds: destination.difference(now).inSeconds,
      interval: const Duration(seconds: 1),
      build: (p0, time) => Scaffold(
        backgroundColor: Colors.blue[400],
        body: Stack(
          alignment: Alignment.center,
          children: [
            CenterTimer(
              remaining: time,
            ),
            Divider(thickness: 10, color: Colors.blue[600]!),
            CountdownEnd(time: time),
            Arby(time: time),
            Gwen(time: time),
          ],
        ),
      ),
    );
  }
}

class CountdownEnd extends StatelessWidget {
  const CountdownEnd({
    super.key,
    required this.time,
  });
  final double time;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      // visible: true,
      visible: time <= 0,
      child: Stack(
        children: [
          const Confetti(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * .2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/love1.gif",
                    height: 100,
                  ),
                  Image.asset(
                    "assets/love1.gif",
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Confetti extends StatelessWidget {
  const Confetti({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        1,
        (index) => Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).size.height * .3),
          child: Center(
            child: Image.asset(
              "assets/confetti.gif",
              height: 140,
            ),
          ),
        ),
      ),
    );
  }
}

class Arby extends StatelessWidget {
  const Arby({
    super.key,
    required this.time,
  });

  final double time;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var diff = destination.difference(start);

    return AnimatedPositioned(
      duration: const Duration(seconds: 1),
      left: (size.width / 2 - 80) *
          ((diff.inSeconds - time) / diff.inSeconds).abs(),
      top: size.height / 2 - 102,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: MirrorAnimationBuilder(
              tween: Tween(begin: 0.0, end: 1.0),
              builder: (context, value, child) => Transform.rotate(
                angle: value - 0.5,
                child: const AutoSizeText(
                  "Arby º_º",
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
              duration: const Duration(seconds: 1),
            ),
          ),
          GifView.asset(
            "assets/arby.gif",
            width: 100,
          ),
        ],
      ),
    );
  }
}

class Gwen extends StatelessWidget {
  const Gwen({
    super.key,
    required this.time,
  });

  final double time;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var diff = destination.difference(start);

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      right: (size.width / 2 - 70) *
          ((diff.inSeconds - time) / diff.inSeconds).abs(),
      top: size.height / 2 - 135,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: MirrorAnimationBuilder(
              tween: Tween(begin: 0.0, end: 0.4),
              builder: (context, value, child) => Transform.rotate(
                angle: value - 0.15,
                child: const AutoSizeText(
                  ">< Gwen",
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
              duration: const Duration(milliseconds: 700),
            ),
          ),
          Transform.scale(
            scaleX: -1,
            child: Image.asset(
              "assets/gwen.gif",
              width: 80,
            ),
          ),
        ],
      ),
    );
  }
}

class CenterTimer extends StatelessWidget {
  const CenterTimer({
    super.key,
    required this.remaining,
  });

  final double remaining;

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Theme(
      data: ThemeData(fontFamily: "BebasNeue"),
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * .05),
          child: AutoSizeText(
            getTextByRemaining(remaining),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "BebasNeue",
              fontSize: 30,
              // fontWeight: FontWeight.bold,
              color: Colors.red[100]!,
            ),
            textScaleFactor: ScaleSize.textScaleFactor(context),
          ),
        ),
      ),
    );
  }

  // get text by day:hour:minute:second by double
  String getTextByRemaining(double remaining) {
    final int day = (remaining / 86400).floor();
    final int hour = ((remaining - day * 86400) / 3600).floor();
    final int minute = ((remaining - day * 86400 - hour * 3600) / 60).floor();
    final int second =
        (remaining - day * 86400 - hour * 3600 - minute * 60).floor();
    var text = [];
    text.add(day.toString().padLeft(2, "0"));
    text.add(hour.toString().padLeft(2, "0"));
    text.add(minute.toString().padLeft(2, "0"));
    text.add(second.toString().padLeft(2, "0"));
    return "${text[0]} Days : ${text[1]} HOURS\n${text[2]} MINUTES : ${text[3]} SECS ";
  }
}

class ScaleSize {
  static double textScaleFactor(BuildContext context,
      {double maxTextScaleFactor = 2}) {
    final width = MediaQuery.of(context).size.width;
    double val = (width / 1400) * maxTextScaleFactor;
    return max(1, min(val, maxTextScaleFactor));
  }
}
