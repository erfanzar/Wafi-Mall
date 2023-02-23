import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wafi_test/views/splash_screen.dart';
import './data/barometer_provider.dart';
import './data/flicker_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //     statusBarIconBrightness: Brightness.dark,
    //     systemNavigationBarIconBrightness: Brightness.dark,
    //     systemNavigationBarColor: Color.fromRGBO(246, 246, 246, 1),
    //     statusBarColor: Color.fromRGBO(246, 246, 246, 1)));
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    // ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: BarometerProvider()),
        ChangeNotifierProvider.value(value: FlickerProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.cyan,
          scaffoldBackgroundColor: const Color(0xff040951),
          primarySwatch: Colors.blue,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
