import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:frnkk/widgets/app_background.dart';
import 'package:google_fonts/google_fonts.dart';
import 'artists_model.dart';

class AllAlbumsView extends StatelessWidget {
  final Artist data;
  const AllAlbumsView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          title: Text(
            "All Albums",
            style: GoogleFonts.poltawskiNowy(
              color: Colors.white,
              fontSize: 26.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () => Get.back(),
          ),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          itemCount: data.albums.length,
          itemBuilder: (context, index) {
            final album = data.albums[index];
            return _buildFullAlbumListItem(album);
          },
        ),
      ),
    );
  }

  Widget _buildFullAlbumListItem(Map<String, String> album) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          // You could navigate to an individual album view if one exists
        },
        borderRadius: BorderRadius.circular(10),
        child: Row(
          children: [
            // 1. Thumbnail Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                album['image']!,
                width: 65,
                height: 65,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 65,
                  height: 65,
                  color: Colors.white10,
                  child: const Icon(Icons.album, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(width: 15),

            // 2. Title and Artist
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    album['title']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // Since individual album objects don't have artists in the mock,
                  // we'll use the profile artist's name
                  Text(
                    data.name,
                    style: const TextStyle(color: Colors.white38, fontSize: 14),
                  ),
                ],
              ),
            ),

            // 3. More Vert
            const Icon(Icons.more_vert, color: Colors.white54),
          ],
        ),
      ),
    );
  }
}
