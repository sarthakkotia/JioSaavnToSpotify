

import 'package:flutter/material.dart';
import 'package:itsamistake/Widgets/dialog.dart';
import 'package:itsamistake/logic.dart/SpotifyLogic/access_token_class.dart';
import 'package:itsamistake/logic.dart/SpotifyLogic/apirequest.dart';
import 'package:itsamistake/logic.dart/SpotifyLogic/authenticateuser.dart';

import '../Widgets/manipulate_users_playlist.dart';

String accessToken = "";
DateTime expiresIn = DateTime.now();

class Step2Screen extends StatefulWidget {
  final List<dynamic> songs;
  const Step2Screen(this.songs, {super.key});

  @override
  State<Step2Screen> createState() => _Step2ScreenState();
}

class _Step2ScreenState extends State<Step2Screen> {
  late AccessTokenClass atc;
  late ApiRequests apireq;
  late Map<String, dynamic> userprofile;
  SpotifyAuthenticateUser sau = SpotifyAuthenticateUser();
  bool _getaccesstokenflag = false;
  bool _playlistoperationsflag = false;

  void authorizeUser() async {
    await sau.authenticateUser();
    setState(() {
      _getaccesstokenflag = true;
    });
  }

  void getAccessToken() async {
    await sau.getaccesstoken();
    Map<String, dynamic> res = sau.res;
    atc = AccessTokenClass(
        access_token: res["access_token"],
        token_type: res["token_type"],
        expires_in: res["expires_in"],
        refresh_token: res["refresh_token"],
        scope: res["scope"]);
    // print(res);
    showDialog(
      context: context,
      builder: (context) => const DialogWidget(),
    );
    apireq = ApiRequests(atc.access_token);
    userprofile = await apireq.getCurrentUserProfile();
    setState(() {
      accessToken = atc.access_token;
      expiresIn = DateTime.now().add(Duration(seconds: atc.expires_in));
      _playlistoperationsflag = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> songs = widget.songs;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Spotify console"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
              onPressed: authorizeUser, child: const Text("Authorize user")),
          ElevatedButton(
              onPressed: _getaccesstokenflag ? getAccessToken : null,
              child: const Text("get access token")),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Access Token : $accessToken",
                      overflow: TextOverflow.ellipsis),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Expires In: $expiresIn"),
                )
              ],
            ),
          ),
          const Divider(),
          if (_playlistoperationsflag)
            ManipulateUserPlaylist(
              apiRequests: apireq,
              accessTokenClass: atc,
              userprofile: userprofile,
              songs: songs,
              expiresin: expiresIn,
            )
        ],
      ),
    );
  }
}
