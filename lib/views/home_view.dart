import 'package:darknet_diaries/core/constant.dart';
import 'package:darknet_diaries/model/model.dart';
import 'package:darknet_diaries/widgets/player_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List episodeList = [];

  Future<void> fetchEpisodeList() async {
    try {
      var response = await Dio().get(
          'https://darknetdiaries.com/darknet-diaries-all-episode-links.txt');
      if (response.statusCode == 200) {
        setState(() {
          episodeList = (response.data as String).split('\n').toList();
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
        actions: [
          IconButton(
              onPressed: () {
                CallApi().getData();
              },
              icon: Icon(Icons.abc))
        ],
        title: Text(
          'Darknet Diaries',
          style: TextStyle(
            color: darknetWhite,
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
                child: Padding(
                  padding: EdgeInsets.only(top: 350),
                  child: Center(
                    child: Text('Try refreshing the page'),
                  ),
                ),
              )
            : ListView.separated(
                itemCount: episodeList.length,
                itemBuilder: (context, index) {
                  return PlayerWidget(episodeName: episodeList);
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
