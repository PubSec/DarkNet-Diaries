import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

// ignore: must_be_immutable
class PlayerWidget extends StatefulWidget {
  String episodeName;
  String episodeNumber;
  PlayerWidget(
      {super.key, required this.episodeName, required this.episodeNumber});

  @override
  State<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  double iconTurns = 1;
  double parentContainerHeight = 80;
  double bottomContainerHeight = 50;
  double sliderValue = 0.0; // Slider value
  int randomInt = Random().nextInt(185);
  dynamic episodeList = [];

  void _togglePlayerSize() {
    setState(() {
      iconTurns = iconTurns == 0.5 ? 1 : 0.5;
      parentContainerHeight = parentContainerHeight == 130 ? 80 : 130;
      bottomContainerHeight = bottomContainerHeight == 400 ? 50 : 400;
    });
  }

  Future<void> fetchRemoteData() async {
    const String link =
        'https://darknetdiaries.com/darknet-diaries-all-episode-links.txt';

    try {
      var response = await Dio().get(link);

      if (response.statusCode == 200) {
        // Assuming the response data is a newline-separated string
        List<String> lines = (response.data as String).split('\n');
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedContainer(
        color: Colors.transparent,
        width: 400,
        height: parentContainerHeight,
        duration: const Duration(milliseconds: 200),
        child: Stack(
          children: [
            AnimatedContainer(
              width: 400,
              height: bottomContainerHeight,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 121, 28, 28),
                borderRadius: BorderRadius.circular(20),
              ),
              duration: const Duration(milliseconds: 400),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Slider(
                        value: sliderValue,
                        onChanged: (newValue) {
                          setState(() {
                            sliderValue = newValue;
                          });
                        },
                        min: 0.0,
                        max: 100,
                        divisions: 100,
                        activeColor: Colors.red,
                        inactiveColor: Colors.black,
                      ),
                    ],
                  ),
                  IconButton(
                    padding: const EdgeInsets.only(left: 30),
                    iconSize: 30,
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_back_ios,
                    ),
                  ),
                  IconButton(
                    padding: const EdgeInsets.only(top: 2),
                    iconSize: 45,
                    onPressed: () {},
                    icon: const Icon(
                      Icons.play_arrow,
                    ),
                  ),
                  IconButton(
                    padding: const EdgeInsets.only(right: 10),
                    iconSize: 30,
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              width: 400,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
              ),
              duration: const Duration(milliseconds: 200),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CircleAvatar(
                      backgroundImage: const AssetImage('assets/image7.jpg'),
                      radius: 30,
                      foregroundImage: AssetImage('assets/image$randomInt.jpg'),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.episodeName,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(widget.episodeNumber),
                      const Text("00:00")
                    ],
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                splashColor: Colors.black,
                onTap: _togglePlayerSize,
                child: Padding(
                  padding: const EdgeInsets.only(right: 18, top: 29),
                  child: AnimatedRotation(
                    turns: iconTurns,
                    duration: const Duration(milliseconds: 200),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(
                        CupertinoIcons.chevron_down,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class RemoteDataModel {
//   String episodeName;
//   String episodeNumber;
//   String episodeLink;
//   Duration episodeDuration;

//   RemoteDataModel({
//     required this.episodeName,
//     required this.episodeNumber,
//     required this.episodeLink,
//     required this.episodeDuration,
//   });
// }

// Future<List<RemoteDataModel>> fetchRemoteData() async {
//   const String link =
//       'https://darknetdiaries.com/darknet-diaries-all-episode-links.txt';

//   try {
//     var response = await Dio().get(link);

//     if (response.statusCode == 200) {
//       List<RemoteDataModel> episodeList = [];

//       // Assuming the response data is a newline-separated string
//       List<String> lines = (response.data as String).split('\n');

//       for (String line in lines) {
//         // Parse each line into an episode (customize this based on actual data format)
//         if (line.isNotEmpty) {
//           // Example parsing, adjust according to the actual data format
//           var parts = line.split('|'); // Assuming '|' is the delimiter
//           if (parts.length >= 4) {
//             String episodeName = parts[0];
//             String episodeNumber = parts[1];
//             String episodeLink = parts[2];
//             Duration episodeDuration = Duration(
//                 minutes:
//                     int.parse(parts[3])); // Assuming duration is in minutes

//             episodeList.add(RemoteDataModel(
//               episodeName: episodeName,
//               episodeNumber: episodeNumber,
//               episodeLink: episodeLink,
//               episodeDuration: episodeDuration,
//             ));
//           }
//         }
//       }

//       // Update your state with the fetched episodeList
//       // You might want to replace this with a proper state management solution
//       setState(() {
//         // Assuming you're in a StatefulWidget
//         this.episodeList = episodeList;
//       });

//       return episodeList;
//     } else {
//       print('Error: ${response.statusCode}');
//       return [];
//     }
//   } catch (e) {
//     print('Exception: $e');
//     return [];
//   }
// }
