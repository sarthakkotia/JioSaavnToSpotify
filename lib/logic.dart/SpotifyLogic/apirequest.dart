import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiRequests {
  final String token;
  ApiRequests(this.token);

  Future<Map<String, dynamic>> getCurrentUserProfile() async {
    final headers = {
      'Authorization': 'Bearer $token',
    };

    final url = Uri.parse('https://api.spotify.com/v1/me');

    final res = await http.get(url, headers: headers);
    final status = res.statusCode;
    if (status != 200) throw Exception('http.get error: statusCode= $status');
    Map<String, dynamic> decodedresponse =
        json.decode(res.body) as Map<String, dynamic>;
    return (decodedresponse);
  }

  Future<List<dynamic>> getcurrentUserPlaylists() async {
    final headers = {
      'Authorization': 'Bearer $token',
    };

    final url =
        Uri.parse('https://api.spotify.com/v1/me/playlists??limit=50&offset=0');

    final res = await http.get(url, headers: headers);
    final status = res.statusCode;
    Map<String, dynamic> decodedresponse =
        json.decode(res.body) as Map<String, dynamic>;
    // print(decodedresponse);
    if (status != 200) throw Exception('http.get error: statusCode= $status');
    decodedresponse = json.decode(res.body) as Map<String, dynamic>;
    return decodedresponse["items"];
    // print(decodedresponse["items"]);
  }

  Future<void> CreateNewPlaylist(String userid, String title) async {
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    final data =
        '{"name": "$title","description": "New playlist description","public": false}';

    final url = Uri.parse('https://api.spotify.com/v1/users/$userid/playlists');

    final res = await http.post(url, headers: headers, body: data);
    final status = res.statusCode;
    // print(res.body);
    if (status != 201) throw Exception('http.post error: statusCode= $status');
    // print(res.body);
  }

  Future<List<dynamic>> SearchForTrack(String song_name) async {
    final headers = {
      'Authorization': 'Bearer $token',
    };

    final params = {
      'q': '$song_name',
      'type': 'track',
      'market': 'IN',
      'limit': '50',
      'offset': '0',
    };

    final url = Uri.parse('https://api.spotify.com/v1/search')
        .replace(queryParameters: params);

    final res = await http.get(url, headers: headers);
    final status = res.statusCode;
    // print(res.body);
    if (status != 200) throw Exception('http.get error: statusCode= $status');
    Map<String, dynamic> test = json.decode(res.body) as Map<String, dynamic>;
    return test["tracks"]["items"];
    // print(test["tracks"]["items"][0]["uri"]);
    // print(test["tracks"]["items"].runtimeType);
  }

  Future<List<String>> GetPlaylistTracks(String id) async {
    // print(id);

    final headers = {
      'Authorization': 'Bearer $token',
    };

    final params = {
      'market': 'IN',
      'fields': 'items(track(name))',
    };

    final url = Uri.parse('https://api.spotify.com/v1/playlists/$id/tracks')
        .replace(queryParameters: params);

    final res = await http.get(url, headers: headers);
    final status = res.statusCode;
    // print(res.body);
    if (status != 200) throw Exception('http.get error: statusCode= $status');
    Map<String, dynamic> test = json.decode(res.body) as Map<String, dynamic>;
    List<dynamic> tracksListResponse = test["items"].toList();
    List<String> tracksName = [];
    for (var element in tracksListResponse) {
      tracksName.add(element["track"]["name"]);
    }
    return tracksName;
  }

  Future<void> AddTracksToPlaylist(String playlistId, String trackUri) async {
    final headers = {
      'Authorization': 'Bearer $token',
    };
    final url = Uri.parse(
        "https://api.spotify.com/v1/playlists/$playlistId/tracks?uris=$trackUri");
    final res = await http.post(url, headers: headers);
    if (res.statusCode != 201)
      throw Exception('http.get error: statusCode= ${res.statusCode}');
    // print(res.body);
  }
}
