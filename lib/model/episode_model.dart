class EpisodeModel {
  final String episodeLink;
  final String episodeName;
  final int episodeId;
  bool isPlaying = false;
  EpisodeModel({
    required this.episodeName,
    required this.episodeLink,
    required this.episodeId,
    required this.isPlaying,
  });
}
