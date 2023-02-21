import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wafi_test/screens/floors/floor_screen.dart';

class ScreenHomePage extends StatefulWidget {
  const ScreenHomePage({Key? key}) : super(key: key);

  @override
  State<ScreenHomePage> createState() => _ScreenHomePageState();
}

class _ScreenHomePageState extends State<ScreenHomePage> {
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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: w / 1.2,
                width: w / 1.2,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/page_one_png_0.png'))),
              ),
              SizedBox(
                  height: h / 8,
                  width: w / 1.4,
                  child: Center(
                    child: Text(
                      'Welcome To Test Application \n Of Checking Floors in Wafi Mall',
                      style: GoogleFonts.montserratAlternates(
                          color: Colors.white, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  )),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ScreenFloorPage()));
                },
                child: Container(
                    height: h / 18,
                    width: w / 3,
                    decoration: BoxDecoration(
                        color: Colors.cyan,
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.cyan,
                              blurStyle: BlurStyle.outer,
                              offset: Offset(0, 0),
                              blurRadius: 15)
                        ],
                        borderRadius: BorderRadius.circular(50)),
                    child: Center(
                      child: Text(
                        'Lets Go !',
                        style: GoogleFonts.montserratAlternates(
                            color: Colors.white, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
