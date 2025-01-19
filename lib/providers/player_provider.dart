import 'package:audioplayers/audioplayers.dart';
import 'package:darknet_diaries/model/episode_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayerNotifier extends Notifier<Map<String, bool>> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Map<String, bool> build() {
    return {}; // Initial state: empty map
  }

  Future<void> togglePlayback(EpisodeModel episodeModel) async {
    try {
      final episodeId =
          episodeModel.episodeId; // Assuming each episode has a unique ID
      final isPlaying = state[episodeId] ?? false;

      if (!isPlaying) {
        // Play the audio from network URL
        await _audioPlayer.play(UrlSource(episodeModel.episodeLink));
        state = {...state, episodeId: true}; // Update the state to playing
      } else {
        // Pause the audio
        await _audioPlayer.pause();
        state = {...state, episodeId: false}; // Update the state to not playing
      }
    } catch (e) {
      debugPrint("Error playing episode: $e");
      // Handle error appropriately
    }
  }
}

final playerNotifierProvider =
    NotifierProvider<PlayerNotifier, Map<String, bool>>(() {
  return PlayerNotifier();
});
