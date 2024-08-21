import 'package:puppycode/apis/models/comment.dart';
import 'package:puppycode/apis/models/reaction.dart';

class Feed {
  Feed(dynamic logItem) {
    id = logItem['id'];
    photoUrl = logItem['photoUrl'];
    title = logItem['title'];
    episode = logItem['content'];
    walkTime = logItem['walkTime'];
    writerId = logItem['writerId'];
    name = logItem['writerNickname'];
    profileUrl = logItem['writerProfileUrl'];
    comments = (logItem['comments'] as List<dynamic>?)
            ?.map((comment) => Comment(comment))
            .toList() ??
        [];
    reactions = (logItem['reactions'] as List<dynamic>?)
            ?.map((reaction) => Reaction(reaction))
            .toList() ??
        [];
    createdAt = logItem['createdAt'];
    formattedCreatedAt = _formatCreatedAt(createdAt);
    isWriter = logItem['me'];
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
  late String title;
  late String episode;
  late String walkTime;
  int? writerId;
  late String name;
  String? profileUrl;
  List<Comment> comments = [];
  List<Reaction> reactions = [];
  late String createdAt;
  late String formattedCreatedAt;
  bool? isWriter;
}
