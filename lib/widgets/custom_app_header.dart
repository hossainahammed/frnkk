import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppHeader extends StatelessWidget {
  final Widget? leftWidget;
  final Widget centerWidget;
  final Widget? rightWidget;

  const CustomAppHeader({
    super.key,
    this.leftWidget,
    required this.centerWidget,
    this.rightWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Padding ensures icons aren't touching the very edge of the screen
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // 1. Left Slot: Takes only the space the icon needs
          if (leftWidget != null) leftWidget!,

          // 2. Center Slot: Takes up all remaining middle space
          Expanded(
            child: centerWidget, 
          ),

          // 3. Right Slot: Takes only the space the icons need
          if (rightWidget != null) rightWidget!,
        ],
      ),
    );
  }
}