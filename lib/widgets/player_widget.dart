import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class PlayerWidget extends StatefulWidget {
  const PlayerWidget({super.key});

  @override
  State<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  double iconTurns = 1;
  double parentContainerHeight = 80;
  double bottomContainerHeight = 50;
  double sliderValue = 0.0; // Slider value
  int randomInt = Random().nextInt(187);

  void _togglePlayerSize() {
    setState(() {
      iconTurns = iconTurns == 0.5 ? 1 : 0.5;
      parentContainerHeight = parentContainerHeight == 130 ? 80 : 130;
      bottomContainerHeight = bottomContainerHeight == 400 ? 50 : 400;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                        radius: 30,
                        backgroundImage: AssetImage('assets/image$randomInt'),
                      ),
                    ),
                    const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Episode Number',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text('Episode Name'),
                        Text("00:00")
                      ],
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: _togglePlayerSize,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 18),
                    child: AnimatedRotation(
                      turns: iconTurns,
                      duration: const Duration(milliseconds: 200),
                      child: const Icon(CupertinoIcons.chevron_down),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
