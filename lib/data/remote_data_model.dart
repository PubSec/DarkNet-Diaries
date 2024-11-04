// import 'package:dio/dio.dart';

// class RemoteDataModel {
//   String episodeName;
//   String episodeNumber;
//   String episodeLink;
//   Duration episodeDuration;

//   RemoteDataModel({
//     required this.episodeName,
//     required this.episodeNumber,
//     required this.episodeLink,
//     required this.episodeDuration,
//   });
// }

// Future<List<RemoteDataModel>> fetchRemoteData() async {
//   const String link =
//       'https://darknetdiaries.com/darknet-diaries-all-episode-links.txt';

//   try {
//     var response = await Dio().get(link);

//     if (response.statusCode == 200) {
//       List<RemoteDataModel> episodeList = [];

//       // Assuming the response data is a newline-separated string
//       List<String> lines = (response.data as String).split('\n');

//       for (String line in lines) {
//         // Parse each line into an episode (customize this based on actual data format)
//         if (line.isNotEmpty) {
//           // Example parsing, adjust according to the actual data format
//           var parts = line.split('|'); // Assuming '|' is the delimiter
//           if (parts.length >= 4) {
//             String episodeName = parts[0];
//             String episodeNumber = parts[1];
//             String episodeLink = parts[2];
//             Duration episodeDuration = Duration(
//                 minutes:
//                     int.parse(parts[3])); // Assuming duration is in minutes

//             episodeList.add(RemoteDataModel(
//               episodeName: episodeName,
//               episodeNumber: episodeNumber,
//               episodeLink: episodeLink,
//               episodeDuration: episodeDuration,
//             ));
//           }
//         }
//       }

//       // Update your state with the fetched episodeList
//       // You might want to replace this with a proper state management solution
//       setState(() {
//         // Assuming you're in a StatefulWidget
//         this.episodeList = episodeList;
//       });

//       return episodeList;
//     } else {
//       print('Error: ${response.statusCode}');
//       return [];
//     }
//   } catch (e) {
//     print('Exception: $e');
//     return [];
//   }
// }
