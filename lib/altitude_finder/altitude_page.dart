import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wafi_test/altitude_finder/library/enviro_sensors.dart';
import 'data/barometer_provider.dart';
import 'data/flicker_provider.dart';
import 'widgets/data_api.dart';
import 'widgets/elevation_streambuilder.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  Stream<BarometerEvent>? _tryStream;
  Stream<String>? _flickerStream;
  double pZeroMock = 1013.25;
  double firstFloor = 0;
  bool hasPlatformException = false;
  bool hasOtherError = false;
  bool isLoading = true;

  late double w;
  late double h;

  @override
  void initState() {
    super.initState();
    try {
      Future.delayed(Duration.zero, () async {
        setState(() {
          isLoading = true;
        });
        final apiData = await handledAPI();
        if (apiData != null) {
          setState(() {
            pZeroMock = apiData[0];
            firstFloor = apiData[1];
          });
        }
        setState(() {
          isLoading = false;
        });
      });
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
          // pZero: provider.previousReading ?? pZero,
          pZero: pZero,
          flickerStream: _flickerStream,
          firstFloor: firstFloor,
        ),
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
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            '$pZeroMock',
            style: TextStyle(color: Colors.white.withOpacity(0.3)),
          ),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.white,
              ))
            : Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: _buildBarometerDisplay(
                      _tryStream!, pZeroMock, barometerProvider),
                ),
              ),
      ),
    );
  }

  // int transform(int value) {
  //   return value;
  // }

  // bool condition(int value) {
  //   return value < 99;
  // }
}
