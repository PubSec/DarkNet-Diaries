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
        print('Error: ${response.statusCode}');
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
        title: const Text('Darknet Diaries'),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: fetchEpisodeList,
        child: episodeList.isEmpty
            ? RefreshIndicator(
                onRefresh: fetchEpisodeList,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.only(
                      top: MediaQuery.sizeOf(context).width / 2),
                  child: Center(
                    child: Text('Try refreshing the page'),
                  ),
                ),
              )
            : ListView.builder(
                itemCount: episodeList.length,
                itemBuilder: (context, index) {
                  return PlayerWidget(
                    episodeName: "Helo", // Assuming the name is the first part
                    episodeNumber:
                        '1', // Assuming the number is the second part
                  );
                },
              ),
      ),
    );
  }
}
