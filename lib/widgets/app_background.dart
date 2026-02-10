import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBackground extends StatelessWidget {
  final Widget child;

  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    const Color baseColor = Color(0xFF080322);
    const Color topLeftGlow = Color(0xFF8A369B);
    const Color rightCenterGlow = Color(0xFF401956);
    const Color bottomMiddleGlow = Color(0xFF4C1E61);

    return Scaffold(
      backgroundColor: baseColor,
      body: Stack(
        children: [
          // 1. TOP LEFT: Glow coming directly from the corner
          Positioned(
            top: -50.h, // Slight offset to bleed off the edge smoothly
            left: -50.w,
            child: Container(
              width: 1.0.sw,
              height: 0.5.sh,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topLeft, // Starts the light at the very corner
                  radius: 0.8,
                  colors: [
                    topLeftGlow.withOpacity(0.7),
                    topLeftGlow.withOpacity(0.0),
                  ],
                  stops: const [0.0, 1.0],
                ),
              ),
            ),
          ),

          // 2. RIGHT SIDE CENTER
          Positioned(
            top: 0.32.sh,
            right: -150.w,
            child: _buildGlow(
              width: 400.w,
              height: 400.h,
              color: rightCenterGlow.withOpacity(0.7),
            ),
          ),

          // 3. BOTTOM MIDDLE: Large Circular Orb
          Positioned(
            bottom: -250.h,
            left: 0,
            right: 0,
            child: Center(
              child: _buildGlow(
                width: 1.5.sw,
                height: 500.h,
                color: bottomMiddleGlow.withOpacity(0.6),
              ),
            ),
          ),

          // 4. CONTENT
          SafeArea(child: child),
        ],
      ),
    );
  }

  Widget _buildGlow({
    required double width,
    required double height,
    required Color color,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          center: Alignment.center,
          radius: 0.5,
          colors: [
            color,
            color.withOpacity(0.0),
          ],
          stops: const [0.0, 0.8],
        ),
      ),
    );
  }
}