import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:enviro_sensors/enviro_sensors.dart';
import 'package:wafi_test/library/enviro_sensors.dart';
import '../data/barometer_provider.dart';
import '../data/flicker_provider.dart';

class ElevationDifferenceStreamBuilder extends StatelessWidget {
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
  Widget build(BuildContext context) {
    // print('pZero = $pZero');
    final barometerProvider =
        Provider.of<BarometerProvider>(context, listen: false);
    final flickerProvider =
        Provider.of<FlickerProvider>(context, listen: false);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        StreamBuilder(
            stream: _tryStream,
            builder:
                (BuildContext context, AsyncSnapshot<BarometerEvent> snap) {
              if (snap.hasError) return Text('Error: ${snap.error}');

              switch (snap.connectionState) {
                case ConnectionState.none:
                  return const Text(
                      'Not connected to the stream or value == Null');
                case ConnectionState.waiting:
                  return const Text('awaiting interaction');
                case ConnectionState.active:
                  final double heightDiff =
                      (log((snap.data!.reading) / (pZero))) * -8434.356429;
                  final String displayHeightDiff =
                      (heightDiff).toStringAsFixed(1);
                  barometerProvider.setPreviousReading(snap.data!.reading);
                  flickerProvider.changingElevationDiff = heightDiff;

                  return Column(
                    children: <Widget>[
                      const Text('Elevation difference since last reset: ',
                          style: TextStyle(
                            color: Colors.black87,
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      FlickeringIcon(
                        stream: _flickerStream,
                        iconData: Icons.arrow_drop_up,
                        directionString: "Ascending",
                      ),
                      Text(
                        '${displayHeightDiff}m',
                        style: const TextStyle(
                            color: Colors.black87, fontSize: 40),
                      ),
                      FlickeringIcon(
                        stream: _flickerStream,
                        iconData: Icons.arrow_drop_down,
                        directionString: "Descending",
                      ),
                    ],
                  );
                case ConnectionState.done:
                  return const Text('Stream has finished');
              }
            }),
      ],
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
                      color: Colors.black87,
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
