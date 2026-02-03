import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Background Gradient
BoxDecoration bgGradient() {
  return const BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color(0xFF2D033B),
        Color(0xFF810CA8),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  );
}

/// Type Selection Tile
Widget typeTile({
  required String title,
  required bool selected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: selected ? Colors.purple : Colors.white54,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Icon(
            selected
                ? Icons.radio_button_checked
                : Icons.radio_button_off,
            color: Colors.purple,
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    ),
  );
}


/// Gender Card
Widget genderCard({
  required String imagePath,
  required bool selected,
}) {
  return Container(
    width: 173,
    height: 173,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: selected ? Colors.purple : Colors.transparent,
        width: 2,
      ),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Stack(
        fit: StackFit.expand,
        children: [
          /// Background Image
          Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),

          /// Selection Overlay
          if (selected)
            Container(
              color: Colors.purple.withOpacity(0.35),
            ),
        ],
      ),
    ),
  );
}



Widget nextButton(VoidCallback onTap) {
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.purple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
      onPressed: onTap,
      child: Text(
        'Next',
        style: GoogleFonts.poltawskiNowy(fontSize: 18, fontWeight: FontWeight.w600,color:Colors.white),
      ),
    ),
  );
}
