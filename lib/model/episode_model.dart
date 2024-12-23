class EpisodeModel {
  // String episodeName;
  String episodeLink;
  EpisodeModel({required this.episodeLink});

  String extractEpisodeNames(episodeName) {
    if (episodeName.length > 52) {
      return episodeName.substring(52).toUpperCase();
    } else {
      return episodeName.toUpperCase();
    }
  }
}
