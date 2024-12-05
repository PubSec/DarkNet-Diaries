import 'package:audioplayers/audioplayers.dart';
import 'package:darknet_diaries/core/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayerWidget extends StatefulWidget {
  final String episodeLink;
  const PlayerWidget({super.key, required this.episodeLink});

  @override
  State<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget> {
  bool isPlaying = false;
  bool isCollapsed = true;
  double iconTurns = 1;
  double parentContainerHeight = 100;
  double bottomContainerHeight = 80;

  // Initialize AssetsAudioPlayer
  final AudioPlayer _audioPlayer = AudioPlayer();

  String extractEpisodeNames(String episodeName) {
    if (episodeName.length > 52) {
      return episodeName.substring(52).toUpperCase();
    } else {
      return episodeName.toUpperCase();
    }
  }

  Future<void> _togglePlayPause() async {
    if (isPlaying) {
      // Pause the audio
      await _audioPlayer.pause();
      setState(() {
        isPlaying = false;
      });
    } else {
      try {
        // Play the audio from network URL
        await _audioPlayer.play(UrlSource(widget.episodeLink));
        setState(() {
          isPlaying = true;
        });
      } catch (e) {
        print("Error playing episode: $e");
      }
    }
  }

  void _togglePlayerSize() {
    setState(() {
      isCollapsed = !isCollapsed;
      iconTurns = isCollapsed ? 1 : 0.5;
      parentContainerHeight = isCollapsed ? 80 : 130;
      bottomContainerHeight = isCollapsed ? 400 : 50;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // Dispose the player when the widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedContainer(
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width,
        height: parentContainerHeight,
        duration: const Duration(milliseconds: 200),
        child: Stack(
          children: [
            // Back side container
            AnimatedContainer(
              width: double.infinity,
              height: bottomContainerHeight,
              decoration: BoxDecoration(
                color: darkDarknetRed,
                borderRadius: BorderRadius.circular(20),
              ),
              duration: const Duration(milliseconds: 400),
            ),
            // Upper container with player controls
            AnimatedContainer(
              width: MediaQuery.of(context).size.width,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(20),
              ),
              duration: const Duration(milliseconds: 200),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(extractEpisodeNames(widget.episodeLink)),
                      IconButton(
                        onPressed: _togglePlayPause,
                        icon: isPlaying
                            ? Icon(Icons.pause)
                            : Icon(Icons.play_arrow),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Chevron arrow on top-right
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
