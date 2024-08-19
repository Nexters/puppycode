class Feed {
  Feed(dynamic logItem) {
    id = logItem['id'];
    photoUrl = logItem['photoUrl'];
    name = logItem['writerNickname'] ?? 'unknown';
    title = logItem['title'];
    createdAt = logItem['createdAt'];
    episode = logItem['content'];
    profileUrl = logItem['writerProfileUrl'];
    formattedCreatedAt = _formatCreatedAt(createdAt);
  }

  static String _formatCreatedAt(String dateString) {
    DateTime parsedDate = DateTime.parse(dateString);
    DateTime date = parsedDate.toUtc().add(const Duration(hours: 9));
    DateTime now = DateTime.now();
    int daysDiff = date.difference(now).inDays.abs();
    bool isYearDifferent = date.year != now.year;
    if (daysDiff > 7) {
      return '${isYearDifferent ? '${date.year}년 ' : ''}${date.month}월 ${date.day}일';
    }
    int hoursDiff = date.difference(now).inHours.abs();
    if (hoursDiff < 1) {
      int minutesDiff = date.difference(now).inMinutes.abs();
      return '$minutesDiff분 전';
    }
    if (hoursDiff < 24) return '$hoursDiff시간 전';
    return '$daysDiff일 전';
  }

  late int id;
  late String photoUrl;
  late String name;
  late String title;
  late String createdAt;
  late String formattedCreatedAt;
  String? episode;
  String? profileUrl;
}
