import 'package:darknet_diaries/core/constant.dart';
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
            onPressed: () async {
              var list = await downloadEpisodeFile();
              print(await episodeList.length);
              setState(() {
                episodeList = list;
              });
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
              itemCount: episodeList.length,
              itemBuilder: (context, index) {
                return PlayerWidget(
                  episodeLink: episodeList[index],
                  episodeList: episodeList,
                );
              },
            ),
    );
  }
}
