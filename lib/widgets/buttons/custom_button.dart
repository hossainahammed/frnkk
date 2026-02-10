import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? color;
  final String? iconPath;
  final bool isGlassy;
  final Color? borderColor; 
  final double? width;
  final double? height;
  final double? fontSize; // 1. Added this

  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color,
    this.iconPath,
    this.isGlassy = false,
    this.borderColor,
    this.width,
    this.height = 48,
    this.fontSize, // 2. Initialize it
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width, // ?? double.infinity, // 3. Changed to infinity so Expanded can work
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isGlassy
              ? Colors.white.withOpacity(0.1)
              : (color ?? const Color(0xFFD357FE)),
          foregroundColor: Colors.white,
          elevation: 0,
          side: borderColor != null 
              ? BorderSide(color: borderColor!, width: 1) 
              : BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          // 4. Reduced horizontal padding for narrow buttons
          padding: const EdgeInsets.symmetric(horizontal: 24), 
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min, 
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconPath != null) ...[
              SvgPicture.asset(iconPath!, height: 22),
              const SizedBox(width: 10),
            ],
            Flexible( // 5. Wrap text in Flexible
              child: Text(
                label,
                maxLines: 1, // 6. Prevent multi-line
                overflow: TextOverflow.ellipsis, // 7. Add dots if too long
                style: GoogleFonts.poltawskiNowy(
                  fontSize: fontSize ?? 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}