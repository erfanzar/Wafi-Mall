import 'package:flutter/material.dart';
import 'package:wafi_test/screens/splash/splash_screen.dart';
import 'screens/home/screen_home.dart';

void main() {
  runApp(const Thread());
}

class Thread extends StatelessWidget {
  const Thread({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
