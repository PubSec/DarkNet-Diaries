import 'package:darknet_diaries/core/constant.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
      ),
      // body: ListView.separated(
      //   itemCount:
      //   itemBuilder: (context, index) {
      //     return PlayerWidget(episodeName: episodeList);
      //   },
      //   separatorBuilder: (BuildContext context, int index) {
      //     return SizedBox(
      //       height: 10,
      //     );
      //   },
      // ),
    );
  }
}
