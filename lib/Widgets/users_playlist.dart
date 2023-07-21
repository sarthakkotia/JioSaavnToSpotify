import 'package:flutter/material.dart';
import 'package:itsamistake/Screens/add_songs_screen.dart';

import '../logic.dart/SpotifyLogic/access_token_class.dart';
import '../logic.dart/SpotifyLogic/apirequest.dart';

class UsersPlaylists extends StatelessWidget {
  const UsersPlaylists(
      {super.key,
      required this.itemcount,
      required this.playlists,
      required this.songs,
      required this.expiresin,
      required this.apiRequests,
      required this.accessTokenClass});

  final int itemcount;
  final List<dynamic> playlists;
  final List<dynamic> songs;
  final DateTime expiresin;
  final ApiRequests apiRequests;
  final AccessTokenClass accessTokenClass;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemcount,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        // print("total: ${playlists[index]["tracks"]["total"]}");
        return InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AddSongsScreen(
                    expiresin: expiresin,
                    songs: songs,
                    playlist_id: playlists[index]["id"],
                    accessTokenClass: accessTokenClass,
                    apiRequests: apiRequests,
                    playlist_length: playlists[index]["tracks"]["total"],
                  ),
                ));
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  SizedBox(
                    width: 125,
                    child: playlists[index]["images"].length > 0
                        ? Image.network(
                            playlists[index]["images"][0]["url"],
                            fit: BoxFit.cover,
                          )
                        : const Icon(
                            Icons.library_music_sharp,
                            size: 125,
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      playlists[index]["name"],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
