import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ListTileResults extends StatelessWidget {
  ListTileResults({
    super.key,
    required this.imageurl,
    required this.albumName,
    required this.trackArtistsList,
    required this.trackName,
    required this.trackUri,
  });
  final String imageurl;
  final String albumName;
  final List<dynamic> trackArtistsList;
  final String trackName;
  final String trackUri;

  String ExtractArtistNames() {
    String artists = "";
    for (int i = 0; i < trackArtistsList.length; i++) {
      var element = trackArtistsList[i];
      if (trackArtistsList.length - i > 1) {
        artists = artists + element["name"] + ", ";
      } else {
        artists = artists + element["name"];
      }
    }
    return artists;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(colors: [
          Theme.of(context).colorScheme.shadow,
          Theme.of(context).colorScheme.onSecondary,
          Theme.of(context).colorScheme.shadow
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      child: ListTile(
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            ExtractArtistNames(),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        // subtitle: Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
        //   child: Text(
        //     trackArtistsList.toString(),
        //   ),
        // ),
        leading: SizedBox(
          height: 64,
          width: 64,
          child: Image.network(
            imageurl,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return Center(
                  child: const CircularProgressIndicator()
                      .animate()
                      .blur()
                      .desaturate(),
                );
              }
            },
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            trackName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
