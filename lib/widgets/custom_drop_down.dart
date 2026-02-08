import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropdown extends StatelessWidget {
  final String hint;
  final String? value;
  final List<String> items;
  final Function(String?) onChanged;

  const CustomDropdown({
    super.key, 
    required this.hint, 
    this.value, 
    required this.items, 
    required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(hint, style: GoogleFonts.poltawskiNowy(color: Colors.white38, fontSize: 14)),
          isExpanded: true,
          dropdownColor: const Color(0xFF1A1A2E), // Dark background for the menu
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white70),
          style: GoogleFonts.poltawskiNowy(color: Colors.white, fontSize: 14),
          items: items.map((String item) {
            return DropdownMenuItem(value: item, child: Text(item));
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}