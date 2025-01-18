class EpisodeModel {
  final String episodeLink;
  final String episodeName;
  final String episodeId;
  bool isPlaying = false;
  EpisodeModel({
    required this.episodeName,
    required this.episodeLink,
    required this.episodeId,
    required this.isPlaying,
  });
}
