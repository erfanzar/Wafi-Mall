import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wafi_test/library/enviro_sensors.dart';
import '../data/barometer_provider.dart';
import '../data/flicker_provider.dart';

import '../widgets/elevation_streambuilder.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  Stream<BarometerEvent>? _tryStream;
  Stream<String>? _flickerStream;
  double pZeroMock = 1013.25;
  bool hasPlatformException = false;
  bool hasOtherError = false;
  int floor = 0;
  late double w;
  late double h;
  patternVibrate() {
    HapticFeedback.mediumImpact();

    sleep(
      const Duration(milliseconds: 200),
    );

    HapticFeedback.mediumImpact();

    sleep(
      const Duration(milliseconds: 500),
    );

    HapticFeedback.mediumImpact();

    sleep(
      const Duration(milliseconds: 200),
    );
    HapticFeedback.mediumImpact();
  }

  @override
  void initState() {
    super.initState();
    try {
      _tryStream = barometerEvents.asBroadcastStream();
    } on PlatformException {
      hasPlatformException = true;
    } catch (error) {
      hasOtherError = true;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Widget> _buildBarometerDisplay(
      Stream<BarometerEvent> stream, double pZero, BarometerProvider provider) {
    if (hasPlatformException) {
      return [
        Text(
          'Platform Exception!',
          style: Theme.of(context).textTheme.headlineMedium,
        )
      ];
    } else if (hasOtherError) {
      return [
        Text(
          'Unexpected Error!',
          style: Theme.of(context).textTheme.headlineMedium,
        )
      ];
    } else {
      return [
        ElevationDifferenceStreamBuilder(
          pressureStream: stream,
          pZero: provider.previousReading ?? pZero,
          flickerStream: _flickerStream,
        ),
        buildFloors(),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    final barometerProvider =
        Provider.of<BarometerProvider>(context, listen: true);
    FlickerProvider flickProvider =
        Provider.of<FlickerProvider>(context, listen: false);
    _flickerStream = flickProvider.directionStream().asBroadcastStream();
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:
              _buildBarometerDisplay(_tryStream!, pZeroMock, barometerProvider),
        ),
      ),
    );
  }

  Widget buildFloors() {
    double boxW = w;
    double boxH = 200;
    double distance = 110;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 500,
        ),
        Positioned(
          bottom: 10,
          child: Opacity(
            opacity: 0.9,
            child: Image.asset(
              'assets/images/box-360_02.gif',
              width: boxW,
              height: 300,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        testButton(),
        Positioned(
          bottom: 170,
          child: AnimatedOpacity(
            opacity: floor >= 1 ? 0.9 : 0.4,
            duration: const Duration(milliseconds: 200),
            child: Image.asset(
              'assets/images/box-360_02.gif',
              width: boxW,
              height: boxH,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        Positioned(
          bottom: 2 * distance + 60,
          child: AnimatedOpacity(
            opacity: floor >= 2 ? 0.9 : 0.4,
            duration: const Duration(milliseconds: 200),
            child: Image.asset(
              'assets/images/box-360_02.gif',
              width: boxW,
              height: boxH,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        Positioned(
          bottom: 3 * distance + 60,
          child: AnimatedOpacity(
            opacity: floor >= 3 ? 0.9 : 0.4,
            duration: const Duration(milliseconds: 200),
            child: Image.asset(
              'assets/images/box-360_02.gif',
              width: boxW,
              height: boxH,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ],
    );
  }

  Widget testButton() {
    return ElevatedButton(
      onPressed: () {
        if (floor < 3) {
          setState(() {
            floor += 1;
          });
        } else if (floor == 3) {
          setState(() {
            floor = 0;
          });
        }
      },
      child: const Text('test'),
    );
  }

  int transform(int value) {
    return value;
  }

  bool condition(int value) {
    return value < 99;
  }
}
