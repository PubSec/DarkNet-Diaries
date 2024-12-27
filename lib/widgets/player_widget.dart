import 'package:darknet_diaries/core/constant.dart';
import 'package:darknet_diaries/providers/player_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayerWidget extends ConsumerStatefulWidget {
  final String episodeLink;
  const PlayerWidget({super.key, required this.episodeLink});

  @override
  ConsumerState<PlayerWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends ConsumerState<PlayerWidget> {
  String extractEpisodeNames(String episodeName) {
    if (episodeName.length > 52) {
      return episodeName.substring(52).toUpperCase();
    } else {
      return episodeName.toUpperCase();
    }
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
                    onPressed: () {
                      ref
                          .watch(playerNotifierProvider.notifier)
                          .getPlayingEpisodes(widget.episodeLink);
                    },
                    icon: ref.watch(playerNotifierProvider),
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
