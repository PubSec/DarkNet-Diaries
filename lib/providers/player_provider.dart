import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayerNotifier extends Notifier<Icon> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;

  @override
  Icon build() {
    return isPlaying ? Icon(Icons.pause) : Icon(Icons.play_arrow);
  }

  Future<void> getPlayingEpisodes(String episodeLink) async {
    try {
      if (!isPlaying) {
        // Play the audio from network URL
        await _audioPlayer.play(UrlSource(episodeLink));
        isPlaying = true; // Update the state
      } else if (isPlaying) {
        // Pause the audio
        await _audioPlayer.pause();
        isPlaying = false; // Update the state
      }

      // Update the icon state

      state = build(); // Rebuild the icon based on the new state
    } catch (e) {
      print("Error playing episode: $e");
    }
  }
}

final playerNotifierProvider = NotifierProvider<PlayerNotifier, Icon>(() {
  return PlayerNotifier();
});
