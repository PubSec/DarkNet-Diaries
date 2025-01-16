import 'package:audioplayers/audioplayers.dart';
import 'package:darknet_diaries/model/episode_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayerNotifier extends Notifier<Icon> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  // bool isPlaying = false;

  @override
  Icon build() {
    return Icon(Icons.play_arrow);
  }

  Future<void> getPlayingEpisodes(EpisodeModel episodeModel) async {
    try {
      if (episodeModel.isPlaying == false) {
        // Play the audio from network URL
        await _audioPlayer.play(UrlSource(episodeModel.episodeLink));
        episodeModel.isPlaying = true; // Update the state
      } else if (episodeModel.isPlaying == true) {
        // Pause the audio
        await _audioPlayer.pause();
        episodeModel.isPlaying = false; // Update the state
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
