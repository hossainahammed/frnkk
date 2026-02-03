import 'package:flutter/material.dart';
import '../../widgets/artist_avatar.dart';

class MostMatchMusicianScreen extends StatelessWidget {
  const MostMatchMusicianScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF2D033B), Color(0xFF080322)],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Musician',
                style: TextStyle(color: Colors.white, fontSize: 22)),

            const SizedBox(height: 16),

            GridView.builder(
              shrinkWrap: true,
              itemCount: 6,
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemBuilder: (_, i) {
                return const ArtistAvatar(
                  imagePath: 'assets/images/artist1.png',
                  name: 'The Weeknd',
                  match: '6 match',
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
