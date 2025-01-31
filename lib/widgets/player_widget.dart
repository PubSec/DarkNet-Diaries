import 'package:darknet_diaries/core/constant.dart';
import 'package:darknet_diaries/model/episode_model.dart';
import 'package:darknet_diaries/providers/player_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayerWidget extends ConsumerWidget {
  final EpisodeModel episode;
  const PlayerWidget({super.key, required this.episode});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playbackStates = ref.watch(playerNotifierProvider);
    final isPlaying = playbackStates[episode.episodeId] ??
        false; // Check the state for this episode

    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  episode.episodeName,
                  style: TextStyle(color: darknetWhite),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  splashColor: darkDarknetRed,
                  splashRadius: 30,
                  onPressed: () {
                    ref
                        .read(playerNotifierProvider.notifier)
                        .togglePlayback(episode);
                  },
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
