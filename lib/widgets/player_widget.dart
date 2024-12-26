import 'package:audioplayers/audioplayers.dart';
import 'package:darknet_diaries/core/constant.dart';
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

  @override
  void dispose() {
    _audioPlayer.dispose(); // Dispose the player when the widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Text(
                extractEpisodeNames(widget.episodeLink),
                style: TextStyle(color: darknetWhite),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: _togglePlayPause,
                    icon:
                        isPlaying ? Icon(Icons.pause) : Icon(Icons.play_arrow),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
