import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenFloorPage extends StatefulWidget {
  const ScreenFloorPage({Key? key}) : super(key: key);

  @override
  State<ScreenFloorPage> createState() => _ScreenFloorPageState();
}

class _ScreenFloorPageState extends State<ScreenFloorPage> {
  int floor = 0;
  late double w;
  late double h;
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Container(
          height: h,
          width: w,
          color: const Color(0xff040951),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
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
              ),
              const SizedBox(height: 50),
              buildFloors(),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Text(
                  'Floor $floor',
                  style: GoogleFonts.montserratAlternates(
                      color: Colors.white, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 50,
              )
            ],
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
          height: 600,
        ),
        Opacity(
          opacity: 0.9,
          child: Image.asset(
            'assets/images/box-360_02.gif',
            width: boxW,
            height: 300,
            fit: BoxFit.fitWidth,
          ),
        ),
        Positioned(
          bottom: 160,
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
          bottom: 2 * distance + 50,
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
          bottom: 3 * distance + 50,
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
}
