import 'package:flutter/material.dart';
import 'select_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isVisible = true;
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 7400), () async {
      setState(() {
        isVisible = false;
      });
      await Future.delayed(const Duration(microseconds: 500));
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const SelectPage()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedOpacity(
        duration: const Duration(milliseconds: 400),
        opacity: isVisible ? 1 : 0,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Image.asset('assets/images/final_color.gif',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              fit: BoxFit.fill),
        ),
      ),
    );
  }
}
