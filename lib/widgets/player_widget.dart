// import 'package:audioplayers/audioplayers.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:darknet_diaries/core/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:rxdart/rxdart.dart';

class PositionData {
  const PositionData(this.position, this.bufferedPosition, this.duration);

  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;
}

// ignore: must_be_immutable
class PlayerWidget extends StatefulWidget {
  List episodeName;
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
  late AudioPlayer _audioPlayer;
  late final _playList = ConcatenatingAudioSource(children: [
    AudioSource.uri(
        Uri.parse(widget.episodeName.toString().split('/n') as String),
        tag: MediaItem(id: '0', title: "title"))
  ]);

  void _togglePlayerSize() {
    setState(() {
      iconTurns = iconTurns == 0.5 ? 1 : 0.5;
      parentContainerHeight = parentContainerHeight == 130 ? 80 : 130;
      bottomContainerHeight = bottomContainerHeight == 400 ? 50 : 400;
    });
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _audioPlayer.positionStream,
        _audioPlayer.bufferedPositionStream,
        _audioPlayer.durationStream,
        (position, bufferedPosition, duration) =>
            PositionData(position, bufferedPosition, duration ?? Duration.zero),
      );

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _init();
  }

  Future<void> _init() async {
    await _audioPlayer.setLoopMode(LoopMode.all);
    await _audioPlayer.setAudioSource(_playList);
  }

  @override
  void dispose() {
    super.dispose();
    _audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedContainer(
        color: Colors.transparent,
        width: 800,
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
                    children: [
                      Container(
                        width: 250,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 10),
                          child: StreamBuilder(
                            stream: _positionDataStream,
                            builder: (context, snapshot) {
                              final positionData = snapshot.data;
                              return ProgressBar(
                                progressBarColor: darknetRed,
                                baseBarColor: darknetGrey,
                                bufferedBarColor: Colors.amber,
                                thumbColor: darknetRed,
                                progress:
                                    positionData?.position ?? Duration.zero,
                                buffered: positionData?.bufferedPosition ??
                                    Duration.zero,
                                total: positionData?.duration ?? Duration.zero,
                                onSeek: _audioPlayer.seek,
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                  // IconButton(
                  //   padding: const EdgeInsets.only(left: 30),
                  //   iconSize: 30,
                  //   onPressed: () {},
                  //   icon: const Icon(
                  //     Icons.arrow_back_ios,
                  //   ),
                  // ),
                  Controls(audioPlayer: _audioPlayer),
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
            // This is the upper container
            AnimatedContainer(
              width: 850,
              height: 80,
              decoration: BoxDecoration(
                // TODO: FIx this
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
                      // Text(
                      //   overflow: TextOverflow.ellipsis,
                      //   widget.episodeName
                      //       .replaceRange(0, 52, "")
                      //       .replaceFirst("-", ' ')
                      //       .toUpperCase(),
                      //   style: TextStyle(
                      //     fontSize: 15,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
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

class Controls extends StatelessWidget {
  const Controls({super.key, required this.audioPlayer});

  final AudioPlayer audioPlayer;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: audioPlayer.seekToPrevious,
            icon: Icon(Icons.skip_previous_rounded)),
        StreamBuilder<PlayerState>(
          stream: audioPlayer.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (!(playing ?? false)) {
              return IconButton(
                  onPressed: audioPlayer.play,
                  icon: Icon(
                    Icons.play_arrow,
                    color: darknetWhite,
                    size: 30,
                  ));
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                onPressed: audioPlayer.pause,
                icon: Icon(
                  Icons.pause_rounded,
                  size: 30,
                  color: darknetWhite,
                ),
              );
            }
            return Icon(
              Icons.play_arrow_rounded,
              size: 1,
              color: darknetWhite,
            );
          },
        ),
        IconButton(
            onPressed: audioPlayer.seekToNext,
            icon: Icon(Icons.skip_next_rounded)),
      ],
    );
  }
}
