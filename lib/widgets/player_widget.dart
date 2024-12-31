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
    return SafeArea(
      child: Container(
        // padding: EdgeInsets.all(8),
        // margin: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  episode.episodeId,
                  style: TextStyle(color: darknetWhite),
                ),
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
                  onPressed: () {
                    ref
                        .watch(playerNotifierProvider.notifier)
                        .getPlayingEpisodes(episode.episodeLink);
                  },
                  icon: ref.watch(playerNotifierProvider),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
