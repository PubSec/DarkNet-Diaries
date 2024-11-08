import 'package:darknet_diaries/core/constant.dart';
import 'package:darknet_diaries/widgets/player_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var episodeList = [];

  Future<void> fetchEpisodeList() async {
    try {
      var response = await Dio().get(
          'https://darknetdiaries.com/darknet-diaries-all-episode-links.txt');
      if (response.statusCode == 200) {
        setState(() {
          episodeList = (response.data as String).split("\n").toList();
        });
        print("length = ${episodeList.length}");
      } else {
        print("Status code not 200");
      }
    } catch (e) {
      print('Exception: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Darknet Diaries',
          style: TextStyle(
            letterSpacing: 4,
            leadingDistribution: TextLeadingDistribution.even,
          ),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        color: darknetRed,
        onRefresh: fetchEpisodeList,
        child: episodeList.isEmpty
            ? SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding:
                    EdgeInsets.only(top: MediaQuery.sizeOf(context).width / 2),
                child: const Center(
                  child: Text('Try refreshing the page'),
                ),
              )
            : ListView.separated(
                itemCount: episodeList.length,
                itemBuilder: (context, index) {
                  return PlayerWidget(
                    episodeName: episodeList[index]
                        .toString(), // Assuming the name is the first part
                    // Assuming the number is the second part
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 10,
                  );
                },
              ),
      ),
    );
  }
}
