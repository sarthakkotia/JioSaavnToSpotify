import 'package:flutter/material.dart';
import 'package:itsamistake/Screens/step2screen.dart';
import 'package:itsamistake/logic.dart/getjiosaavndata.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

enum JioSaavnList { A, B, C, O, R2, Nov4, B2022, R, Feb10, M }

JioSaavnData jsd = JioSaavnData();

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late JioSaavnList playlist = JioSaavnList.A;
  String dropdownvalue = "A Tier";
  Map<String, dynamic> data = {};
  Map<String, dynamic> test = {};
  List<dynamic> songs = [];
  bool load = false;
  bool pressedstart = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Jiosaavn to spotify?"),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButton(
              value: dropdownvalue,
              items: const [
                DropdownMenuItem<String>(
                  value: "Mixed Queue",
                  child: Text("Mixed Queue"),
                ),
                DropdownMenuItem<String>(
                  value: "A Tier",
                  child: Text("A Tier"),
                ),
                DropdownMenuItem<String>(
                  value: "B Tier",
                  child: Text("B Tier"),
                ),
                DropdownMenuItem<String>(
                  value: "C Tier",
                  child: Text("C Tier"),
                ),
                DropdownMenuItem<String>(
                  value: "Old Songs",
                  child: Text("Old Songs"),
                ),
                DropdownMenuItem<String>(
                  value: "Rock",
                  child: Text("Rock"),
                ),
                DropdownMenuItem<String>(
                  value: "4/11",
                  child: Text("Nov 4"),
                ),
                DropdownMenuItem<String>(
                  value: "10/2",
                  child: Text("Feb 10"),
                ),
                DropdownMenuItem<String>(
                  value: "Best of 2022",
                  child: Text("Best of 2022"),
                ),
                DropdownMenuItem<String>(
                  value: "Rock I guess",
                  child: Text("Rock I guess"),
                ),
              ],
              onChanged: (String? val) {
                setState(() {
                  dropdownvalue = val!;
                  // print(dropdownvalue);
                  switch (val) {
                    case "A Tier":
                      playlist = JioSaavnList.A;
                      break;
                    case "B Tier":
                      playlist = JioSaavnList.B;
                      break;
                    case "C Tier":
                      playlist = JioSaavnList.C;
                      break;
                    case "Old Songs":
                      playlist = JioSaavnList.O;
                      break;
                    case "Rock I guess":
                      playlist = JioSaavnList.R2;
                      break;
                    case "4/11":
                      playlist = JioSaavnList.Nov4;
                      break;
                    case "Best of 2022":
                      playlist = JioSaavnList.B2022;
                      break;
                    case "Rock":
                      playlist = JioSaavnList.R;
                      break;
                    case "10/2":
                      playlist = JioSaavnList.Feb10;
                      break;
                    case "Mixed Queue":
                      playlist = JioSaavnList.M;
                      break;
                  }
                });
              },
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  load = true;
                  pressedstart = true;
                });

                await jsd.getdata(playlist);
                setState(() {
                  load = false;
                  test = jsd.decodedResponse;
                  data = test["data"];
                  songs = data["songs"];
                });
              },
              child: const Text("Start "),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Container(
                height: 50,
                color: test["status"] == "SUCCESS"
                    ? Colors.lightGreen
                    : Colors.red,
                child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                          "id:${data["id"]}   songCount:${data["songCount"]}"),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height - 370,
                width: MediaQuery.of(context).size.width,
                child: load == true
                    ? const Center(child: CircularProgressIndicator())
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: AnimationLimiter(
                            child: Scrollbar(
                          child: ListView.builder(
                            itemCount:
                                data.isNotEmpty ? data["songs"].length : 0,
                            itemBuilder: (context, index) {
                              return AnimationConfiguration.staggeredList(
                                  position: index,
                                  child: SlideAnimation(
                                    verticalOffset: 50.0,
                                    child: FadeInAnimation(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 2),
                                        child: ListTile(
                                          title: Text(
                                              data["songs"][index]["name"]),
                                          subtitle: Text(
                                            data["songs"][index]
                                                ["primaryArtists"],
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ));
                            },
                          ),
                        )),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: ElevatedButton.icon(
                  onPressed: pressedstart
                      ? () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return Step2Screen(songs);
                            },
                          ));
                        }
                      : null,
                  icon: const Icon(Icons.navigate_next),
                  label: const Text("Step 2")),
            )
          ],
        ),
      ),
    );
  }
}
