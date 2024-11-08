// import 'package:audioplayers/audioplayers.dart';
import 'package:darknet_diaries/core/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:just_audio/just_audio.dart';

// ignore: must_be_immutable
class PlayerWidget extends StatefulWidget {
  String episodeName;
  PlayerWidget({super.key, required this.episodeName});

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
  final player = AudioPlayer();

  void _togglePlayerSize() {
    setState(() {
      iconTurns = iconTurns == 0.5 ? 1 : 0.5;
      parentContainerHeight = parentContainerHeight == 130 ? 80 : 130;
      bottomContainerHeight = bottomContainerHeight == 400 ? 50 : 400;
    });
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
                color: darkDarknetRed,
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
                        activeColor: darknetRed,
                        inactiveColor: darknetBlack,
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
                    onPressed: () {
                      Duration? duration =
                          AudioSource.uri(Uri.parse(widget.episodeName))
                              .duration;
                      print(duration);
                    },
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
                color: darknetBlack,
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
                        overflow: TextOverflow.ellipsis,
                        widget.episodeName
                            .replaceRange(0, 52, "")
                            .replaceFirst("-", ' ')
                            .toUpperCase(),
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          // Audio Start
                          const Text("00:00"),
                          SizedBox(
                            width: 30,
                            child: Icon(Icons.linear_scale_outlined),
                          ),
                          // Audio Finish
                          const Text("00:00")
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                splashColor: darknetBlack,
                onTap: _togglePlayerSize,
                child: Padding(
                  padding: const EdgeInsets.only(right: 18, top: 29),
                  child: AnimatedRotation(
                    turns: iconTurns,
                    duration: const Duration(milliseconds: 200),
                    child: Container(
                      decoration: BoxDecoration(
                        color: darknetGrey,
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
