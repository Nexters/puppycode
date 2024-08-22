class Reaction {
  Reaction(dynamic reactionItem) {
    id = reactionItem['id'];
    writerId = reactionItem['writerId'];
    writerName = reactionItem['writerNickname'];
    writerProfileUrl = reactionItem['writerProfileImageUrl'];
    reactionType = reactionItem['reactionType'].toLowerCase();
    walkLogId = reactionItem['walkLogId'];
    createdAt = reactionItem['createdAt'];
    isWriter = reactionItem['me'];
  }

  late int id;
  late int writerId;
  late String writerName;
  late String writerProfileUrl;
  late String reactionType;
  late int walkLogId;
  late String createdAt;
  late bool isWriter;
}
