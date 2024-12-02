// All the functions needed for the app
// import 'dart:io';
import 'package:darknet_diaries/core/constant.dart';
// import 'package:dio/dio.dart';
// import 'package:path_provider/path_provider.dart';

// Future<List<String>> downloadEpisodeFile() async {
//   var appDir = await getApplicationDocumentsDirectory();
//   String fullPath = "${appDir.path}/darknetdiaries.txt";
//   print(fullPath);
//   Response downloadSatus = await Dio().download(darknetUrl, fullPath);
//   print(downloadSatus.statusCode);
//   final file = File(fullPath);
//   final fileContents = await file.readAsLines();
//   // print(fileContents);
//   return fileContents;
// }
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

Future<List<String>> downloadEpisodeFile() async {
  try {
    // Get the application documents directory
    var appDir = await getApplicationDocumentsDirectory();
    String fullPath = "${appDir.path}/darknetdiaries.txt";
    print("Download will save to: $fullPath");

    // Start downloading the file from the specified URL
    Response downloadStatus = await Dio().download(darknetUrl, fullPath);
    print("Download Status: ${downloadStatus.statusCode}");

    // If download is successful (HTTP status code 200)
    if (downloadStatus.statusCode == 200) {
      final file = File(fullPath);

      // Check if the file exists and read its content
      if (await file.exists()) {
        final fileContents = await file.readAsLines();
        print("File content downloaded and read successfully.");
        return fileContents;
      } else {
        print("File does not exist after download.");
        return [];
      }
    } else {
      print(
          "Failed to download file. Status code: ${downloadStatus.statusCode}");
      return [];
    }
  } catch (e) {
    // Handle potential errors during download or file I/O
    print("Error during file download: $e");
    return [];
  }
}
