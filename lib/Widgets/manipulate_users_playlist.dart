import 'package:flutter/material.dart';
import 'package:itsamistake/Widgets/playlist_name_dialog.dart';
import 'package:itsamistake/Widgets/users_playlist.dart';
import 'package:itsamistake/logic.dart/SpotifyLogic/access_token_class.dart';

import '../logic.dart/SpotifyLogic/apirequest.dart';

class ManipulateUserPlaylist extends StatefulWidget {
  ApiRequests apiRequests;
  AccessTokenClass accessTokenClass;
  Map<String, dynamic> userprofile;
  final List<dynamic> songs;
  final DateTime expiresin;
  ManipulateUserPlaylist(
      {required this.apiRequests,
      required this.userprofile,
      required this.accessTokenClass,
      required this.songs,
      required this.expiresin,
      super.key});

  @override
  State<ManipulateUserPlaylist> createState() => _ManipulateUserPlaylistState();
}

class _ManipulateUserPlaylistState extends State<ManipulateUserPlaylist> {
  List<dynamic> playlists = [];

  @override
  Widget build(BuildContext context) {
    Future<void> getCurrectUserPlaylists() async {
      var test = await widget.apiRequests.getcurrentUserPlaylists();
      setState(() {
        playlists = test;
        // print(playlists[0]["tracks"]["total"]);
        // print(itemcount);
      });
    }

    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        ElevatedButton(
          onPressed: getCurrectUserPlaylists,
          child: Text("Get ${widget.userprofile["display_name"]}'s playlists"),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
          height: 200,
          child: UsersPlaylists(
            itemcount: playlists.length,
            playlists: playlists,
            songs: widget.songs,
            expiresin: widget.expiresin,
            apiRequests: widget.apiRequests,
            accessTokenClass: widget.accessTokenClass,
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        ElevatedButton(
            onPressed: () async {
              String? textnullable = await showDialog<String>(
                context: context,
                builder: (context) {
                  return const PlaylistNameDialog();
                },
              );
              if (textnullable != null) {
                await widget.apiRequests
                    .CreateNewPlaylist(widget.userprofile["id"], textnullable);
                await getCurrectUserPlaylists();
              }
            },
            child: const Text("Create New Playlist"))
      ],
    );
  }
}
