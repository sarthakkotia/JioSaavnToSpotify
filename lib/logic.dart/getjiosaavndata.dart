import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:itsamistake/Screens/homescree.dart';

class JioSaavnData {
  String data = "";
  List<String> Tiers = [
    "1073058005",
    "1073058820",
    "1073062688",
    "",
    "1111206294",
    "1097632025",
    "1093934639",
    "1115664708",
    "1091651111",
    "1141257285"
  ];
  Map<String, dynamic> decodedResponse = {};
  late String parameter;
  Future<void> getdata(JioSaavnList jsd) async {
    switch (jsd) {
      case JioSaavnList.A:
        parameter = Tiers[0];
        break;
      case JioSaavnList.B:
        parameter = Tiers[1];
        break;
      case JioSaavnList.C:
        parameter = Tiers[2];
        break;
      case JioSaavnList.B2022:
        parameter = Tiers[3];
        break;
      case JioSaavnList.R:
        parameter = Tiers[4];
        break;
      case JioSaavnList.R2:
        parameter = Tiers[5];
        break;
      case JioSaavnList.O:
        parameter = Tiers[6];
        break;
      case JioSaavnList.M:
        parameter = Tiers[7];
        break;
      case JioSaavnList.Nov4:
        parameter = Tiers[8];
        break;
      case JioSaavnList.Feb10:
        parameter = Tiers[9];
        break;
    }
    final response =
        await http.get(Uri.parse("https://saavn.me/playlists?id=${parameter}"));
    data = response.body;
    decodedResponse = await json.decode(response.body);
  }
}
