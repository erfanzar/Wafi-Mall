import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wafi_test/views/home_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
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
              onTap: () async {
                setState(() {
                  isPressed = true;
                });
                await Future.delayed(const Duration(milliseconds: 90));
                setState(() {
                  isPressed = false;
                });
                // ignore: use_build_context_synchronously
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyHomePage()));
              },
              child: AnimatedContainer(
                  height: h / 18,
                  width: w / 3,
                  duration: const Duration(milliseconds: 100),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      boxShadow: [
                        isPressed
                            ? BoxShadow(
                                color: Theme.of(context).primaryColor,
                                blurStyle: BlurStyle.outer,
                                // offset: Offset(0, 0),
                                blurRadius: 2)
                            : BoxShadow(
                                color: Theme.of(context).primaryColor,
                                blurStyle: BlurStyle.outer,
                                // offset: Offset(0, 0),
                                blurRadius: 15),
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
    );
  }
}
