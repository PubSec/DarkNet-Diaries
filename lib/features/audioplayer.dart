import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

final dio = Dio();

class AudioModel {
  fetchListFile() async {
    var response = await dio.download(
      'https://darknetdiaries.com/darknet-diaries-all-episode-links.txt',
      '${(await getApplicationDocumentsDirectory()).path}darknet-diaries-all-episode-links.txt',
    );
  }

  loadFile(File file) async {
    Directory directory = await getApplicationDocumentsDirectory();
    String directoryPath = directory.path;
  }
}
