import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:wafi_test/altitude_finder/altitude_page.dart';

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
                child: const Center(
                  child: Text(
                    'Welcome to test application \n of checking floors in WafiMall',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      letterSpacing: 0.7,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )),
            GestureDetector(
              onTapDown: (_) {
                setState(() {
                  isPressed = true;
                });
              },
              onTapUp: (_) async {
                await Future.delayed(const Duration(milliseconds: 50));

                setState(() {
                  isPressed = false;
                });
              },
              onTapCancel: () async {
                await Future.delayed(const Duration(milliseconds: 50));
                setState(() {
                  isPressed = false;
                });
              },
              onTap: () async {
                await Future.delayed(const Duration(milliseconds: 100));
                // ignore: use_build_context_synchronously
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyHomePage()));
              },
              child: AnimatedContainer(
                  height: isPressed ? h / 18.1 : h / 18,
                  width: isPressed ? w / 3.05 : w / 3,
                  duration: const Duration(milliseconds: 100),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context).primaryColor,
                            blurStyle: BlurStyle.outer,
                            // offset: Offset(0, 0),
                            blurRadius: isPressed ? 8 : 16),
                        BoxShadow(
                            color: Theme.of(context).primaryColor,
                            blurStyle: BlurStyle.outer,
                            // offset: Offset(0, 0),
                            blurRadius: 3)
                      ],
                      borderRadius: BorderRadius.circular(50)),
                  child: const Center(
                    child: Text(
                      'Lets Go!',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
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
