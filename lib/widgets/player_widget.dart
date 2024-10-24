import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayerWigdet extends StatefulWidget {
  const PlayerWigdet({super.key});

  @override
  State<PlayerWigdet> createState() => _PlayerWigdetState();
}

class _PlayerWigdetState extends State<PlayerWigdet> {
  double turns = 1;
  double height = 60;
  double width = 300;
  double bottomHeight = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedContainer(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.black),
          duration: const Duration(
            milliseconds: 400,
          ),
          height: height,
          width: width,
          child: Stack(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                height: bottomHeight,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.green,
                ),
                child: const SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Icon(
                        CupertinoIcons.play,
                        color: Colors.white,
                      ),
                      Icon(
                        CupertinoIcons.play,
                        color: Colors.white,
                      ),
                      Icon(
                        CupertinoIcons.play,
                        color: Colors.white,
                      ),
                      Icon(
                        CupertinoIcons.play,
                        color: Colors.white,
                      ),
                      Icon(
                        CupertinoIcons.play,
                        color: Colors.white,
                      ),
                      Icon(CupertinoIcons.pause),
                    ],
                  ),
                ),
              ),
              Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent),
                child: const Center(
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: CircleAvatar(
                          backgroundImage: AssetImage(
                            'assets/axe.jpg',
                          ),
                          radius: 20,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Episode Number',
                              style: TextStyle(fontSize: 22),
                            ),
                            Text(
                              'Episode Name',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 5, bottom: 5),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    child: AnimatedRotation(
                      turns: turns,
                      duration: const Duration(microseconds: 1000),
                      child: const Icon(CupertinoIcons.chevron_down),
                    ),
                    onTap: () {
                      setState(() {
                        turns = turns == 0.5 ? 1 : 0.5;
                        bottomHeight = bottomHeight == 0 ? 140 : 0;
                      });
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
