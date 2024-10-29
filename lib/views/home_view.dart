import 'package:darknet_diaries/widgets/player_widget.dart';
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
        title: const Text('Darknet Diaries'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 250,
        itemBuilder: (context, index) {
          return const PlayerWidget();
        },
      ),
    );
  }
}

// class FileContentListView extends StatefulWidget {
//   const FileContentListView({super.key});

//   @override
//   _FileContentListViewState createState() => _FileContentListViewState();
// }

// class _FileContentListViewState extends State<FileContentListView> {
//   List<String> items = [];
//   final player = AudioPlayer();
//   int? playingIndex; // Track which item is currently playing
//   int start = 0;
//   int end = 0;

//   Future<Duration?> togglePlayPause(String url, int index) async {
//     if (playingIndex == index) {
//       await player.pause(); // Pause if the same item is clicked
//       setState(() {
//         playingIndex = null; // Reset playing index
//       });
//       return null; // Return null if paused
//     } else {
//       print(url);
//       await player.play(UrlSource(url)); // Play the new item

//       setState(() {
//         playingIndex = index; // Update the playing index
//       });

//       // Wait for the player to get the duration after starting playback
//       Duration? duration = await player.getDuration();
//       return duration; // Return the audio duration
//     }
//   }

//   Future<void> fetchListFile() async {
//     final dio = Dio();
//     try {
//       final directory = await getApplicationDocumentsDirectory();
//       final filePath =
//           '${directory.path}/darknet-diaries-all-episode-links.txt';

//       // Delete existing file if it exists
//       final file = File(filePath);
//       if (await file.exists()) {
//         await file.delete();
//       }

//       // Download the file
//       await dio.download(
//         'https://darknetdiaries.com/darknet-diaries-all-episode-links.txt',
//         filePath,
//       );

//       // Read the file content and split it into lines
//       String fileContent = await file.readAsString();
//       setState(() {
//         items = fileContent.split('\n'); // Split content by new lines
//       });
//     } catch (e) {
//       print('Error occurred while downloading the file: $e');
//     }
//   }
// }
