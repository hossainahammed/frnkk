// The Model
class Artist {
  final String name, role, location, image, bio, connections;
  final List<Map<String, String>> albums;
  final List<Map<String, String>> audioTracks;
  final List<Map<String, dynamic>> languages;
  final List<String> skills;
  final List<String> genres;

  // Added Experience Fields
  final Map<String, String>
  professionalJourney; // e.g., {"role": "Singer . Songwriter", "years": "4 year+"}
  final List<Map<String, String>> experiences; // The timeline items
  final List<Map<String, String>>
  experienceStatus; // The mic cards at the bottom

  Artist({
    required this.name,
    required this.role,
    required this.location,
    required this.image,
    required this.bio,
    required this.connections,
    required this.albums,
    required this.audioTracks,
    required this.languages,
    required this.skills,
    required this.genres,
    required this.professionalJourney,
    required this.experiences,
    required this.experienceStatus,
  });
}

// The Mock Data
class ArtistMockData {
  static final List<Artist> artists = [
    Artist(
      name: "Taylor Swift",
      role: "Singer",
      location: "Nashville, USA",
      connections: "100 Connections",
      image: "assets/images/artists_profile_images/taylor.png",
      bio:
          "and asd sad sa edfasdhjasd asd asas dsad asd asd d saTsadasdasa sda dsa  dsad  sad dsylor Swift is an American singer songwriter sadasdfsdfdsgjsdk dsfjsdkj dsjf kdsjf jdlksg jg jrftgdkls jksdfj jlsdkfjg lkjsdf kldsfjgkdfjgk jdsfj sdkfk jdskfj kfjdg",
      audioTracks: [
        {
          "title": "A & W",
          "genre": "Classical",
          "artist": "Salena Gomez",
          "image": "assets/images/album_images/album1.png",
        },
        {
          "title": "The Blackest Day",
          "genre": "Hip Hop",
          "artist": "Lana Del Rey",
          "image": "assets/images/album_images/album2.png",
        },
        {
          "title": "The Blackest Day",
          "genre": "Classical",
          "artist": "Lana Del Rey",
          "image": "assets/images/album_images/album1.png",
        },
        {
          "title": "The Blackest Day",
          "genre": "Classical",
          "artist": "Lana Del Rey",
          "image": "assets/images/album_images/album1.png",
        },
        {
          "title": "The Blackest Day",
          "genre": "Classical",
          "artist": "Lana Del Rey",
          "image": "assets/images/album_images/album1.png",
        },
        {
          "title": "The Blackest Day",
          "genre": "Classical",
          "artist": "Lana Del Rey",
          "image": "assets/images/album_images/album1.png",
        },
        {
          "title": "The Blackest Day",
          "genre": "Classical",
          "artist": "Lana Del Rey",
          "image": "assets/images/album_images/album1.png",
        },
        {
          "title": "The Blackest Day",
          "genre": "Classical",
          "artist": "Lana Del Rey",
          "image": "assets/images/album_images/album1.png",
        },
      ],

      albums: [
        {
          "title": "Ocean Blvd",
          "image": "assets/images/album_images/album1.png",
        },
        {"title": "NFR", "image": "assets/images/album_images/album2.png"},
        {
          "title": "Ocean Blvd",
          "image": "assets/images/album_images/album1.png",
        },
        {
          "title": "Ocean Blvd",
          "image": "assets/images/album_images/album1.png",
        },
      ],
      languages: [
        {"name": "English", "value": 0.9},
        {"name": "Spanish", "value": 0.8},
        {"name": "French", "value": 0.7},
      ],
      skills: ["Vocal", "Harmony", "Lyric writing", "Electronic", "Classical"],
      genres: [
        "Hip-hop",
        "R&B",
        "Alternative",
        "Pop",
        "Rock",
        "Electronic",
        "Jazz",
      ],
      professionalJourney: {
        "role": "Singer . Songwriter",
        "years": "4 year+ Learn track",
      },
      experiences: [
        {
          "yearTop": "2026",
          "yearBottom": "Present",
          "role": "Lead Vocalist",
          "project": "Independent Studio Project",
          "period": "2024 - Present",
          "description":
              "Recorded vocals for pop and R&B tracks. Collaborated with producers and lyricists for studio and live projects.",
        },
        {
          "yearTop": "2024",
          "yearBottom": "-2022",
          "role": "Lead Vocalist",
          "project": "Independent Studio Project",
          "period": "2024 - Present",
          "description":
              "Recorded vocals for pop and R&B tracks. Collaborated with producers and lyricists for studio and live projects.",
        },
      ],
      experienceStatus: [
        {
          "count": "120 +",
          "label": "Song Record",
          "genres": "Pop, Classic, Hip Hop",
        },
        {
          "count": "20 +",
          "label": "Live Performance",
          "genres": "Pop, Classic, Hip Hop",
        },
      ],
    ),
  ];
}
