import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:enviro_sensors/enviro_sensors.dart';
import 'package:wafi_test/library/enviro_sensors.dart';
import '../data/barometer_provider.dart';
import '../data/flicker_provider.dart';

class ElevationDifferenceStreamBuilder extends StatefulWidget {
  ElevationDifferenceStreamBuilder({
    Key? key,
    @required Stream<BarometerEvent>? pressureStream,
    @required double? pZero,
    @required flickerStream,
  })  : _tryStream = pressureStream!,
        pZero = pZero!,
        _flickerStream = flickerStream,
        super(key: key);

  final Stream<BarometerEvent> _tryStream;
  final Stream<String> _flickerStream;
  final double pZero;

  @override
  State<ElevationDifferenceStreamBuilder> createState() =>
      _ElevationDifferenceStreamBuilderState();
}

class _ElevationDifferenceStreamBuilderState
    extends State<ElevationDifferenceStreamBuilder> {
  int floor = 0;
  @override
  Widget build(BuildContext context) {
    double boxW = MediaQuery.of(context).size.width;
    double boxH = 200;
    double distance = 110;
    // print('pZero = $pZero');
    final barometerProvider =
        Provider.of<BarometerProvider>(context, listen: false);
    final flickerProvider =
        Provider.of<FlickerProvider>(context, listen: false);
    return Center(
      child: StreamBuilder(
        stream: widget._tryStream,
        builder: (BuildContext context, AsyncSnapshot<BarometerEvent> snap) {
          if (snap.hasError) return Text('Error: ${snap.error}');

          switch (snap.connectionState) {
            case ConnectionState.none:
              return const Text(
                'Not connected to the stream or value == Null',
                style: TextStyle(color: Colors.white),
              );
            case ConnectionState.waiting:
              return const Text(
                'awaiting interaction',
                style: TextStyle(color: Colors.white),
              );
            case ConnectionState.active:
              final double heightDiff =
                  (log((snap.data!.reading) / (widget.pZero))) * -8434.356429;
              final String displayHeightDiff = (heightDiff).toStringAsFixed(1);
              barometerProvider.setPreviousReading(snap.data!.reading);
              flickerProvider.changingElevationDiff = heightDiff;
              //calcualte the floor
              floor = heightDiff > 69
                  ? (heightDiff - 69) ~/ 6.5
                  : (heightDiff - 69) ~/ 6.5 - 1;
              String floorOrder = 'ground floor';
              switch (floor) {
                case 1:
                  floorOrder = 'first floor';
                  break;
                case 2:
                  floorOrder = 'second floor';
                  break;
                case 3:
                  floorOrder = 'third floor';
                  break;
                case 4:
                  floorOrder = 'third floor';
                  break;
                case -1:
                case -2:
                case -3:
                case -4:
                  floorOrder = 'floor';
              }
              return Column(
                children: <Widget>[
                  Column(
                    children: [
                      FlickeringIcon(
                        stream: widget._flickerStream,
                        iconData: Icons.arrow_drop_up,
                        directionString: "Ascending",
                      ),
                      Text(
                        '${displayHeightDiff}m',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 30),
                      ),
                      FlickeringIcon(
                        stream: widget._flickerStream,
                        iconData: Icons.arrow_drop_down,
                        directionString: "Descending",
                      ),
                    ],
                  ),
                  Stack(
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
                            height: boxH,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: distance + 10,
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
                        bottom: 2 * distance + 10,
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
                        bottom: 3 * distance + 10,
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
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Your on $floorOrder $floor',
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              );
            case ConnectionState.done:
              return const Text('Stream has finished');
          }
        },
      ),
    );
  }
}

class FlickeringIcon extends StatelessWidget {
  final Stream<String>? stream;
  final IconData? iconData;
  final String? directionString;
  const FlickeringIcon(
      {Key? key, this.stream, this.iconData, this.directionString})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot<String> snap) {
          if (snap.hasError) {
            return Icon(
              iconData,
              size: 30,
              color: const Color.fromRGBO(246, 246, 246, 1.0),
            );
          }

          switch (snap.connectionState) {
            case ConnectionState.none:
              return Icon(
                iconData,
                size: 30,
                color: const Color.fromRGBO(246, 246, 246, 1.0),
              );
            case ConnectionState.waiting:
              return Icon(
                iconData,
                size: 30,
                color: const Color.fromRGBO(246, 246, 246, 1.0),
              );
            case ConnectionState.active:
              return snap.data == directionString
                  ? Icon(
                      iconData,
                      size: 30,
                      color: Colors.lightGreen,
                    )
                  : Icon(
                      iconData,
                      size: 30,
                      color: const Color.fromRGBO(246, 246, 246, 1.0),
                    );

            case ConnectionState.done:
              return Icon(
                iconData,
                size: 30,
                color: const Color.fromRGBO(246, 246, 246, 1.0),
              );
          }
        });
  }
}
