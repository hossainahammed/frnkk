import 'package:flutter/material.dart';

class ArtistAvatar extends StatelessWidget {
  final String imagePath;
  final String name;
  final String match;
  final bool selected;

  const ArtistAvatar({
    super.key,
    required this.imagePath,
    required this.name,
    required this.match,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? Colors.purple : Colors.transparent,
                  width: 2,
                ),
              ),
              child: CircleAvatar(
                radius: 32,
                backgroundImage: AssetImage(imagePath),
              ),
            ),
            if (selected)
              const Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  radius: 8,
                  backgroundColor: Colors.purple,
                  child: Icon(Icons.check, size: 10, color: Colors.white),
                ),
              )
          ],
        ),
        const SizedBox(height: 6),
        Text(name,
            style: const TextStyle(color: Colors.white, fontSize: 12)),
        Text(match,
            style: const TextStyle(color: Colors.white54, fontSize: 10)),
      ],
    );
  }
}
