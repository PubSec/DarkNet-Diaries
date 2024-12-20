import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:darknet_diaries/core/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

class PositionData {
  const PositionData(this.position, this.bufferedPosition, this.duration);

  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;
}

// ignore: must_be_immutable
class PlayerWidget extends StatefulWidget {
  String episodeLink;
  List<String> episodeList;
  PlayerWidget(
      {super.key, required this.episodeLink, required this.episodeList});

  @override
  State<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  double iconTurns = 1;
  double parentContainerHeight = 100;
  double bottomContainerHeight = 80;
  int randomInt = Random().nextInt(31);
  late AudioPlayer _audioPlayer;
  late final _playList = ConcatenatingAudioSource(
      children: widget.episodeList
          .map((url) => AudioSource.uri(
              Uri.parse(url))) // Convert each URL string to an AudioSource
          .toList());

  // Extracts the name of the episode
  String extractEpisodeNames(String episodeName) {
    String name = episodeName.substring(52).toUpperCase();
    return name;
  }

  // Triggers the animation to show the play button
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
            // The back side of the container
            AnimatedContainer(
              width: 10000,
              height: bottomContainerHeight,
              decoration: BoxDecoration(
                color: darkDarknetRed,
                borderRadius: BorderRadius.circular(20),
              ),
              duration: const Duration(milliseconds: 400),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 250,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: StreamBuilder(
                            stream: _positionDataStream,
                            builder: (context, snapshot) {
                              final positionData = snapshot.data;
                              return ProgressBar(
                                progressBarColor: darknetRed,
                                baseBarColor: darknetWhite,
                                bufferedBarColor: darkDarkNetGrey,
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
                  Controls(
                    audioPlayer: _audioPlayer,
                  ),
                ],
              ),
            ),
            // This is the upper container in the stack layer
            AnimatedContainer(
              width: 850,
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
                    children: [Text(extractEpisodeNames(widget.episodeLink))],
                  )
                ],
              ),
            ),
            // This is for the little arrow on side of the widgets
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
              size: 30,
              color: darknetWhite,
            );
          },
        ),
        IconButton(
          onPressed: audioPlayer.seekToNext,
          icon: Icon(Icons.skip_next_rounded),
        ),
      ],
    );
  }
}
