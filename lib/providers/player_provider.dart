import 'package:audioplayers/audioplayers.dart';
import 'package:darknet_diaries/model/episode_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayerNotifier extends Notifier<bool> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  // bool isPlaying = false;

  @override
  bool build() {
    return false;
  }

  Future<bool> getPlayingEpisodes(EpisodeModel episodeModel) async {
    try {
      if (episodeModel.isPlaying == false) {
        // Play the audio from network URL
        await _audioPlayer.play(UrlSource(episodeModel.episodeLink));
        episodeModel.isPlaying = true;
        state = true;
        state = build();
        return state; // Update the state
      } else if (episodeModel.isPlaying == true) {
        // Pause the audio
        await _audioPlayer.pause();
        episodeModel.isPlaying = false; // Update the state
        state = false;
        state = build();
        return state;
      }
      // Update the icon state
      // Rebuild the icon based on the new state
    } catch (e) {
      debugPrint("Error playing episode: $e");
    }
    throw '';
  }
}

final playerNotifierProvider = NotifierProvider<PlayerNotifier, bool>(() {
  return PlayerNotifier();
});
