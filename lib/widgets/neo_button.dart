import 'package:flutter/material.dart';

class NeoButton extends StatefulWidget {
  final double diameter;
  final String text;
  final Widget? routeTarget;
  const NeoButton({
    required this.diameter,
    required this.text,
    this.routeTarget,
    super.key,
  });

  @override
  State<NeoButton> createState() => _NeoButtonState();
}

class _NeoButtonState extends State<NeoButton> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          isPressed = true;
        });
        await Future.delayed(const Duration(milliseconds: 210));
        setState(() {
          isPressed = false;
        });
        await Future.delayed(const Duration(milliseconds: 190));
        if (widget.routeTarget != null) {
          // ignore: use_build_context_synchronously
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => widget.routeTarget!));
        }
      },
      child: AnimatedContainer(
        // curve: Curves.easeInOutCirc,
        duration: const Duration(milliseconds: 210),
        height: isPressed ? widget.diameter * 0.995 : widget.diameter,
        width: isPressed ? widget.diameter * 0.995 : widget.diameter,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 4, 9, 73),
              offset: isPressed ? const Offset(3, 3) : const Offset(4, 4),
              blurRadius: isPressed ? 10 : 20,
              spreadRadius: 1,
            ),
            BoxShadow(
              color: const Color.fromARGB(255, 46, 55, 189),
              offset: isPressed ? const Offset(-8, -8) : const Offset(-10, -10),
              blurRadius: isPressed ? 10 : 15,
              spreadRadius: isPressed ? 3 : 4,
            ),
          ],
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 46, 55, 189),
              Color.fromARGB(255, 4, 9, 81),
              Color.fromARGB(255, 4, 11, 102),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.2, 0.9, 1],
          ),
        ),
        child: Center(
          child: SizedBox(
            width: widget.diameter * 0.9,
            child: Center(
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 210),
                style: TextStyle(
                  fontFamily: 'montserrat',
                  color: Colors.white.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                  fontSize: isPressed
                      ? widget.diameter / 6.1 - 0.5
                      : widget.diameter / 6.1,
                  shadows: const [
                    Shadow(color: Colors.cyan, blurRadius: 12),
                    // Shadow(color: Colors.cyan, blurRadius: 30),
                    Shadow(color: Colors.cyan, blurRadius: 50),
                    Shadow(color: Colors.cyan, blurRadius: 90),
                    Shadow(color: Colors.white, blurRadius: 4),
                  ],
                ),
                child: Text(widget.text),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
