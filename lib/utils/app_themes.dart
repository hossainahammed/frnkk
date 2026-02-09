import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDecorations {
  static const Color baseColor = Color(0xFF080322);
  static const Color topLeftGlow = Color(0xFF8A369B);
  static const Color rightCenterGlow = Color(0xFF401956);
  static const Color bottomMiddleGlow = Color(0xFF4C1E61);

  static Widget buildFullBackground() {
    return Stack(
      children: [
        // 1. The Solid Deep Base
        Container(color: baseColor),

        // 2. TOP LEFT: Corner-Anchored Glow
        // We set alignment to topLeft so the purple core starts at the edge
        Positioned(
          top: -20.h, // Minimal offset so the "core" is visible in the corner
          left: -20.w,
          child: Container(
            width: 1.0.sw,
            height: 0.5.sh,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topLeft, // Anchor color to the top-left corner
                radius: 1.0,
                colors: [
                  topLeftGlow.withOpacity(0.7),
                  topLeftGlow.withOpacity(0.0),
                ],
                stops: const [0.0, 0.8],
              ),
            ),
          ),
        ),

        // 3. VERTICALLY RIGHT SIDE CENTER: The focused "Side Glow"
        Positioned(
          top: 0.32.sh,
          right: -150.w,
          child: _glowSpot(
            width: 400.w,
            height: 400.h,
            color: rightCenterGlow.withOpacity(0.7),
            stops: [0.0, 0.8],
          ),
        ),

        // 4. BOTTOM MIDDLE: The Bottom Circle Orb
        Positioned(
          bottom: -250.h,
          left: 0,
          right: 0,
          child: Center(
            child: _glowSpot(
              width: 1.5.sw,
              height: 500.h,
              color: bottomMiddleGlow.withOpacity(0.6),
              stops: [0.0, 0.7],
            ),
          ),
        ),
      ],
    );
  }

  /// Refined Glow Spot with RadialGradient (Centered version)
  static Widget _glowSpot({
    required double width,
    required double height,
    required Color color,
    required List<double> stops,
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
          stops: stops,
        ),
      ),
    );
  }
}