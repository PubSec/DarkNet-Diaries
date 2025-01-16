import 'package:darknet_diaries/core/constant.dart';
import 'package:darknet_diaries/model/episode_model.dart';
import 'package:darknet_diaries/providers/episode_provider.dart';
import 'package:darknet_diaries/widgets/player_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    Future allEpisodes =
        ref.watch(episodeNotifierProvider.notifier).getEpisodes();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Darknet Diaries',
          style: TextStyle(
            color: darknetWhite,
            letterSpacing: 6,
            fontWeight: FontWeight.bold,
            leadingDistribution: TextLeadingDistribution.even,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: allEpisodes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While the future is loading

            return Center(child: CircularProgressIndicator(color: darknetRed));
          } else if (snapshot.hasError) {
            // If there was an error

            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // If the data is empty

            return Center(child: Text('No episodes found.'));
          } else {
            // If the data is available

            List<EpisodeModel> episodes = snapshot.data!;

            return ListView.separated(
              cacheExtent: 5,
              itemCount: episodes.length,
              itemBuilder: (context, index) {
                return PlayerWidget(
                  episode: episodes[index],
                );
              },
              separatorBuilder: (BuildContext context, int index) => SizedBox(
                height: 20,
              ),
            );
          }
        },
      ),
    );
  }
}
