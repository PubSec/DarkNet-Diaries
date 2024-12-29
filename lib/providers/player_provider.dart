import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayerNotifier extends Notifier<Icon> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  String currentlyPlaying = '';

  @override
  Icon build() {
    return isPlaying ? Icon(Icons.pause) : Icon(Icons.play_arrow);
  }

  Future<void> getPlayingEpisodes(String episodeLink) async {
    try {
      if (!isPlaying && episodeLink != currentlyPlaying) {
        // Play the audio from network URL
        await _audioPlayer.play(UrlSource(episodeLink));
        currentlyPlaying = episodeLink;
        isPlaying = true; // Update the state
        print(currentlyPlaying);
      } else if (isPlaying && episodeLink == currentlyPlaying) {
        // Pause the audio
        await _audioPlayer.pause();
        isPlaying = false; // Update the state
        currentlyPlaying = '';
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
