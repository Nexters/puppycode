class Reaction {
  Reaction(dynamic commentItem) {
    id = commentItem['id'];
    writerName = commentItem['writerNickname'];
    writerProfileUrl = commentItem['writerProfileImageUrl'];
    reactionType = (commentItem['reactionType'] as String).toLowerCase();
    walkLogId = commentItem['walkLogId'];
    createdAt = commentItem['createdAt'];
  }

  late int id;
  late String writerName;
  late String writerProfileUrl;
  late String reactionType;
  late int walkLogId; // 이건뭐징
  late String createdAt;
}
