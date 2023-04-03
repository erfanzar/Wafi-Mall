import 'package:flutter/material.dart';
import 'package:wafi_test/altitude_finder/welcome_page.dart';
import '../widgets/neo_button.dart';

//*** Add your page at line 43 ****

class SelectPage extends StatefulWidget {
  const SelectPage({super.key});

  @override
  State<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends State<SelectPage> {
  bool isVisible = false;
  @override
  void initState() {
    Future.delayed(
      const Duration(microseconds: 100),
      () {
        setState(() {
          isVisible = true;
        });
      },
    );
    super.initState();
  }

  Widget _buildButtons() {
    return Center(
      child: Stack(children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 600,
        ),
        const Positioned(
          top: 35,
          left: -30,
          child: SizedBox(
            child: Center(
              child: NeoButton(
                diameter: 320,
                text: 'Indicator',
                // add your page here!
                // routeTarget: ExamplePage() ,
              ),
            ),
          ),
        ),
        const Positioned(
          bottom: 35,
          right: 0,
          child: SizedBox(
            child: Center(
              child: NeoButton(
                diameter: 220,
                text: 'Elevator',
                routeTarget: WelcomePage(),
              ),
            ),
          ),
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedOpacity(
        duration: const Duration(milliseconds: 400),
        opacity: isVisible ? 1 : 0,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.deepPurple.shade900.withOpacity(0.1),
                Theme.of(context).scaffoldBackgroundColor,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: _buildButtons(),
        ),
      ),
    );
  }
}
