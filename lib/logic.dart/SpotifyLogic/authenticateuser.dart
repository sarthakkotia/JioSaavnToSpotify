import 'dart:convert';

import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;

class SpotifyAuthenticateUser {
  final String _clientId = "6e20e2e6aeb34218adac929ef07bd5bf";
  final String _clientSecret = "bab4f7084a53442ab3d01cb2f52238eb";
  final String _responseType = "code";
  final String _redirectURi = "itsamistake://callback";
  final String _scope =
      "playlist-read-private playlist-modify-private playlist-modify-public user-read-email user-read-private";
  final String _state = "toldyouitsamistake";
  final bool _showDialog = true;
  String _accessToken = "";
  String _code = "";
  Map<String, dynamic> res = {};
  Future<void> authenticateUser() async {
    Uri authUrl = Uri.parse(
        "https://accounts.spotify.com/authorize?response_type=${_responseType}&client_id=${_clientId}&scope=${_scope}&redirect_uri=${_redirectURi}&show_dialog=${_showDialog}&state=${_state}");
    // var result = launchUrl(authUrl);
    final result = await FlutterWebAuth.authenticate(
        url: "${authUrl.toString()}", callbackUrlScheme: "itsamistake");
    _code = Uri.parse(result).queryParameters['code']!;
    // final state = Uri.parse(result).queryParameters['state'];
    // print(
    //     "test-----------------------------------------------------------------------------------------------------------");
    // print("code : $_code");
    // print("state : $state");
    // print(
    //     "end------------------------------------------------------------------------------------------------");

// Extract token from resulting url
//     final token = Uri.parse(result).queryParameters['token'];
//     print("autthentication");
//     Uri authUrl = Uri.parse(
//         "https://accounts.spotify.com/authorize?response_type=${_responseType}&client_id=${_clientId}&scope=${_scope}&redirect_uri=${_redirectURi}&show_dialog=${_showDialog}");
//     print(authUrl);
  }

  Future<void> getaccesstoken() async {
    Uri accesstokenuri = Uri.parse("https://accounts.spotify.com/api/token");
    String encoded =
        base64.encode(utf8.encode("${_clientId}:${_clientSecret}"));
    // String decode = utf8.decode(base64.decode(encoded));

    Map<String, String> headersList = {
      'Authorization': 'Basic $encoded',
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    Map<String, String> body = {
      'code': _code,
      'redirect_uri': _redirectURi,
      'grant_type': 'authorization_code',
    };

    final response =
        await http.post(accesstokenuri, headers: headersList, body: body);
    if (response.statusCode == 200) {
      Map<String, dynamic> decodedresponse =
          json.decode(response.body) as Map<String, dynamic>;
      _accessToken = decodedresponse["access_token"];
      res = decodedresponse;
      return;
    }

    // var res = await req.send();
    // final resBody = await res.stream.bytesToString();
    //
    // if (res.statusCode >= 200 && res.statusCode < 300) {
    //   print(resBody);
    // } else {
    //   print(res.reasonPhrase);
    // }
  }
}
