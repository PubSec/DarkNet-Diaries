import 'dart:core';
import 'dart:io';
import 'package:darknet_diaries/core/constant.dart';
import 'package:darknet_diaries/model/episode_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

class EpisodeNotifier extends Notifier<Future<List<EpisodeModel>>> {
  @override
  Future<List<EpisodeModel>> build() {
    return Future.value([]);
  }

  Future<List<EpisodeModel>> getEpisodes() async {
    String extractEpisodeName(String episodeName) {
      if (episodeName.length > 52) {
        String name = episodeName.split('ep')[1];
        return name.toUpperCase();
      }
      return '';
    }

    String extractEpisodeNumber(String episodeName) {
      if (episodeName.length > 52) {
        String nameWithNumber = extractEpisodeName(episodeName);
        String episodeNumber = nameWithNumber.split('-')[0];
        return episodeNumber;
      }
      return '';
    }

    try {
      // Get the application documents directory
      var appDir = await getTemporaryDirectory();
      String fullPath = "${appDir.path}/darknetdiaries.txt";
      debugPrint("Download will save to: $fullPath");

      // Start downloading the file from the specified URL
      Response downloadStatus = await Dio().download(darknetUrl, fullPath);
      debugPrint("Download Status: ${downloadStatus.statusCode}");

      // If download is successful (HTTP status code 200)
      if (downloadStatus.statusCode == 200) {
        final file = File(fullPath);

        // Check if the file exists and read its content
        if (await file.exists()) {
          final fileContents = await file.readAsLines();
          if (kDebugMode) {
            debugPrint("File content downloaded and read successfully.");
          }

          List<EpisodeModel> episodes = fileContents
              .map(
                (episodeLink) => EpisodeModel(
                    episodeLink: episodeLink,
                    episodeName: extractEpisodeName(episodeLink),
                    episodeId: extractEpisodeNumber(episodeLink),
                    isPlaying: false),
              )
              .toList();
          return Future.value(episodes);
        } else {
          debugPrint("File does not exist after download.");
          return [];
        }
      } else {
        debugPrint(
            "Failed to download file. Status code: ${downloadStatus.statusCode}");
        return [];
      }
    } catch (e) {
      // Handle potential errors during download or file I/O
      debugPrint("Error during file download: $e");
      return [];
    }
  }
}

final episodeNotifierProvider =
    NotifierProvider<EpisodeNotifier, Future<List<EpisodeModel>>>(() {
  return EpisodeNotifier();
});
