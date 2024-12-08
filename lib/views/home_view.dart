import 'package:darknet_diaries/core/constant.dart';
import 'package:darknet_diaries/core/error_widget.dart';
import 'package:darknet_diaries/core/functions.dart';
import 'package:darknet_diaries/widgets/player_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<String> episodeList = [];

  Future<void> _loadEpisodeData() async {
    List<String> episodeLinks = await downloadEpisodeFile();
    if (episodeLinks.isEmpty) {
      print("No episodes found or download failed.");
      showDialog(
          context: context,
          builder: (context) {
            return CustomErrorWidget();
          });
    } else {
      print("Downloaded episode links: ${episodeLinks.length}");
      // Process the episode links (e.g., populate the UI)
      setState(() {
        episodeList = episodeLinks;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
        actions: [
          IconButton(
            onPressed: () {
              _loadEpisodeData();
            },
            icon: Icon(CupertinoIcons.arrow_uturn_down),
          )
        ],
      ),
      body: episodeList.isEmpty
          ? Center(
              child: Text(
                "Press the button above",
                style: TextStyle(color: darknetWhite),
              ),
            )
          : ListView.builder(
              cacheExtent: episodeList.length / 2,
              itemCount: episodeList.length,
              itemBuilder: (context, index) {
                return PlayerWidget(
                  key: ValueKey(episodeList[index]),
                  episodeLink: episodeList[index],
                );
              },
            ),
    );
  }
}
