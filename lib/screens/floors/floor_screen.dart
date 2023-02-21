import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenFloorPage extends StatefulWidget {
  const ScreenFloorPage({Key? key}) : super(key: key);

  @override
  State<ScreenFloorPage> createState() => _ScreenFloorPageState();
}

class _ScreenFloorPageState extends State<ScreenFloorPage> {
  int floor = 2;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: h,
          width: w,
          color: const Color(0xff040951),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: h - ((130 * 4) + 95),
              ),
              floor >= 3
                  ? Container(
                      height: 130,
                      width: w,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/floor_one.png'),
                              fit: BoxFit.fitHeight)),
                    )
                  : SizedBox(
                      height: 130,
                      width: w,
                    ),
              floor >= 2
                  ? Container(
                      height: 130,
                      width: w,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/floor_one.png'),
                              fit: BoxFit.fitHeight)),
                    )
                  : SizedBox(
                      height: 130,
                      width: w,
                    ),
              floor >= 1
                  ? Container(
                      height: 130,
                      width: w,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/floor_one.png'),
                              fit: BoxFit.fitHeight)),
                    )
                  : SizedBox(
                      height: 130,
                      width: w,
                    ),
              Container(
                height: 130,
                width: w,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/floor_one.png'),
                        fit: BoxFit.fitHeight)),
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
}
