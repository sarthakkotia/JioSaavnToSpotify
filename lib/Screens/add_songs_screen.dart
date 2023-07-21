import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:itsamistake/Screens/success_screen.dart';
import 'package:itsamistake/Widgets/Widgets-ListTile/search_result_list_tile.dart';

import '../Widgets/Widgets-ListTile/searching_list_tile.dart';
import '../logic.dart/SpotifyLogic/access_token_class.dart';
import '../logic.dart/SpotifyLogic/apirequest.dart';

class AddSongsScreen extends StatefulWidget {
  final String playlist_id;
  final List<dynamic> songs;
  final DateTime expiresin;
  final ApiRequests apiRequests;
  final AccessTokenClass accessTokenClass;
  final int playlist_length;
  const AddSongsScreen(
      {required this.expiresin,
      required this.songs,
      required this.playlist_id,
      required this.accessTokenClass,
      required this.apiRequests,
      required this.playlist_length,
      super.key});

  @override
  State<AddSongsScreen> createState() => _AddSongsScreenState();
}

class _AddSongsScreenState extends State<AddSongsScreen> {
  int i = -1;
  bool _startsearching = false;
  final TextEditingController _searchbar = TextEditingController();
  bool _issearchloading = false;
  late List<dynamic> tracks;
  String tempsongname = "";
  bool _skipsong = false;

  void skipsong() {
    setState(() {
      _skipsong = true;
      i++;
    });
  }

  void searchfortrack(ApiRequests apireq, String song_name) async {
    if (tempsongname == song_name) {
      return;
    }
    setState(() {
      _issearchloading = true;
    });
    List<String> userSpotifyPlaylistTracks =
        await apireq.GetPlaylistTracks(widget.playlist_id);
    // print(userSpotifyPlaylistTracks);
    // print(song_name);
    bool isSongInPlaylist = false;
    for (int i = 0; i < userSpotifyPlaylistTracks.length; i++) {
      if (userSpotifyPlaylistTracks[i].contains(song_name)) {
        isSongInPlaylist = true;
        break;
      }
    }
    if (isSongInPlaylist == true) {
      skipsong();
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: const Duration(milliseconds: 500),
            content: Text(
                "$song_name skipped as it's already present in the Selected Spotify playlist")));
      });
    }
    tracks = await apireq.SearchForTrack(song_name);
    // log(tracks.toString());
    // print(test.runtimeType);
    setState(() {
      _issearchloading = false;
    });
    // log(test.toString());
  }

  void addtrack(ApiRequests apireq, String playlistId, String trackUri,
      String songName) async {
    await apireq.AddTracksToPlaylist(playlistId, trackUri);
    setState(() {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("$songName has been added to playlist"),
        duration: const Duration(milliseconds: 500),
      ));
      skipsong();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> songs = widget.songs;
    if (i == songs.length) {
      return const SuccessScreen();
    }
    ApiRequests apireq = widget.apiRequests;
    //print(widget.playlist_id);
    // print(widget.expiresin);
    // print(widget.playlist_length);

    if (i >= 0 &&
        (_searchbar.text == tempsongname || _skipsong == true) &&
        i < songs.length) {
      _skipsong = false;
      String trimmedname = songs[i]["name"].toString();
      int idx = trimmedname.indexOf("(");
      if (idx != -1) {
        trimmedname = trimmedname.substring(0, idx);
      }
      _searchbar.text = trimmedname;
      searchfortrack(apireq, trimmedname);
      tempsongname = trimmedname;
    }
    return _startsearching && i <= songs.length
        ? Scaffold(
            resizeToAvoidBottomInset: false,
            bottomNavigationBar: LinearProgressIndicator(
              minHeight: 8,
              value: i / songs.length,
            ),
            bottomSheet: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text("$i / ${songs.length}",
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(fontSize: 16),
                  )),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 3),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                        "Expires on: ${DateFormat("hh:mm:ss a").format(widget.expiresin)}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(
                    "Searching for:",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                SearchingForListTile(songs: songs, i: i),
                const Divider(),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 5),
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 80,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                bottom: 2, left: 5, right: 5),
                            child: TextField(
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder()),
                              controller: _searchbar,
                              onSubmitted: (value) {
                                _searchbar.text = value;
                                searchfortrack(apireq, value);
                              },
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            searchfortrack(apireq, _searchbar.text.trim());
                          },
                          child: const Center(
                              child: Icon(Icons.search_sharp, size: 45)),
                        )
                      ],
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    skipsong();
                  },
                  icon: const Icon(Icons.navigate_next),
                  label: const Text("Skip"),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 373,
                  width: MediaQuery.of(context).size.width,
                  child: _issearchloading == true
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                              itemBuilder: (context, index) {
                                // print(i);
                                var details = tracks[index];
                                // log(" external_urls ${tracks[index]["album"]["external_urls"]}");
                                // log(" images ${tracks[index]["album"]["images"][0]}");
                                // log(" Album-name ${tracks[index]["album"]["name"]}");
                                // log("Album-artists ${tracks[index]["album"]["artists"][0]["name"]}");
                                // log("track-artists ${tracks[index]["artists"]}");
                                // log("track-external-urls ${tracks[index]["external_urls"]}");
                                // log("track-name ${tracks[index]["name"]}");
                                // log("track-preview-url ${tracks[index]["preview_url"]}");
                                // log("track-uri ${details["uri"]}");
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: InkWell(
                                      onTap: () {
                                        addtrack(apireq, widget.playlist_id,
                                            details["uri"], details["name"]);
                                      },
                                      borderRadius: BorderRadius.circular(15),
                                      child: ListTileResults(
                                        albumName: details["album"]["name"],
                                        imageurl: details["album"]["images"][0]
                                            ["url"],
                                        trackArtistsList: details["artists"],
                                        trackName: details["name"],
                                        trackUri: details["uri"],
                                      ).animate().fadeIn().shimmer(
                                            angle: 45,
                                            delay: const Duration(
                                                milliseconds: 1200),
                                          )),
                                );
                              },
                              itemCount: tracks.length),
                        ),
                )
              ],
            ),
          )
        : Scaffold(
            body: Center(
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      skipsong();
                      _startsearching = true;
                    });
                  },
                  child: const Text("Start Searching")),
            ),
          );
  }
}
