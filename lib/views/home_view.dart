import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  var backgroundColors = <Color>[Colors.black,Colors.red];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Darknet Diaries'),
        centerTitle: true,
      ),
      body:  Container(decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.black,Colors.red.shade300],end: Alignment.bottomLeft)),
        child: FileContentListView(
          
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(elevation:0 ,backgroundColor:  Colors.transparent,items: const [BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),BottomNavigationBarItem(icon: Icon(Icons.file_download_done),label: "Downloads")]),
    );
  }
}

class FileContentListView extends StatefulWidget {
  const FileContentListView({super.key});

  @override
  _FileContentListViewState createState() => _FileContentListViewState();
}

class _FileContentListViewState extends State<FileContentListView> {
  List<String> items = [];
  final player = AudioPlayer();
  int? playingIndex; // Track which item is currently playing
  int start = 0;
  int end = 0;

  @override
  void initState() {
    super.initState();
    fetchListFile();
  }

  Future<Duration?> togglePlayPause(String url, int index) async {
    if (playingIndex == index) {
      await player.pause(); // Pause if the same item is clicked
      setState(() {
        playingIndex = null; // Reset playing index
      });
      return null; // Return null if paused
    } else {
      print(url);
      await player.play(UrlSource(url)); // Play the new item

      setState(() {
        playingIndex = index; // Update the playing index
      });

      // Wait for the player to get the duration after starting playback
      Duration? duration = await player.getDuration();
      return duration; // Return the audio duration
    }
  }

  Future<void> fetchListFile() async {
    final dio = Dio();
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath =
          '${directory.path}/darknet-diaries-all-episode-links.txt';

      // Delete existing file if it exists
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
      }
      

      // Download the file
      await dio.download(
        'https://darknetdiaries.com/darknet-diaries-all-episode-links.txt',
        filePath,
      );

      // Read the file content and split it into lines
      String fileContent = await file.readAsString();
      setState(() {
        items = fileContent.split('\n'); // Split content by new lines
      });
    } catch (e) {
      print('Error occurred while downloading the file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final itemUrl = items[index];
        return ListTile(
          title: Text(
            itemUrl
                .substring(itemUrl.indexOf('ep'))
                .replaceAll('-', ' ')
                .toUpperCase(),
          ),
          trailing: IconButton(
            onPressed: () {
              togglePlayPause(itemUrl, index);
              print(itemUrl);

            },
            icon: playingIndex == index
                ? const Icon(CupertinoIcons.pause)
                : const Icon(CupertinoIcons.play),
          ),
        );
      },
    );
  }
}

