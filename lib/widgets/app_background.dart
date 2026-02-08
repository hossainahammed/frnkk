import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  final Widget child;

  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(-0.8, -0.8), // Purple glow top-left
          radius: 1.5,
          colors: [
            Color.fromARGB(1, 142, 55, 159), // Deep Purple
            Color(0xFF000000), // Black
          ],
        ),
      ),
      child: child,
    );
  }
}