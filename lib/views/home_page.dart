import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wafi_test/library/enviro_sensors.dart';
import '../data/barometer_provider.dart';
import '../data/flicker_provider.dart';
// import 'package:http/http.dart' as http;
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
  bool isLoading = true;
  int floor = 0;
  late double w;
  late double h;

  Future<double> getPressure() async {
    final client = HttpClient();
    final request = await client.getUrl(Uri.parse(
        'http://api.weatherapi.com/v1/current.json?key=01636e4be0ab41a892a101404232802&q=dubai&aqi=no'));
    final response = await request.close();
    print('''************
${response.statusCode.toString()}
************
''');
    final contentAsString = await utf8.decodeStream(response);
    final map = json.decode(contentAsString);
    double? pressure = map['current']['pressure_in'] * 33.8638 + 1;
    pressure ??= 1013.25;
    setState(() {
      isLoading = false;
    });
    return pressure;
  }

  @override
  void initState() {
    super.initState();
    try {
      Future.delayed(Duration.zero, () async {
        pZeroMock = await getPressure();
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
        ),
        // buildFloors(),
        Text(
          '$pZeroMock',
          style: const TextStyle(color: Colors.white),
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
            opacity: 1,
            child: Image.asset(
              'assets/images/box-360_02.gif',
              width: boxW,
              height: 300,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        Positioned(
          bottom: 170,
          child: AnimatedOpacity(
            opacity: floor >= 1 ? 1 : 0.4,
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
            opacity: floor >= 2 ? 1 : 0.4,
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
            opacity: floor >= 3 ? 1 : 0.4,
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

  int transform(int value) {
    return value;
  }

  bool condition(int value) {
    return value < 99;
  }
}
