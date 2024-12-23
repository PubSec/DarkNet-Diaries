// All the functions needed for the app
// import 'dart:io';
// import 'package:darknet_diaries/core/constant.dart';
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
// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:path_provider/path_provider.dart';

Future<List<String>> downloadEpisodeFile() async {
  return [];
}
