class Comment {
  Comment(dynamic commentItem) {
    id = commentItem['id'];
    content = commentItem['content'];
    writerId = commentItem['writerId'];
    writerName = commentItem['writerNickname'];
    writerProfileUrl = commentItem['writerProfileImageUrl'];
    walkLogId = commentItem['walkLogId'];
    createdAt = commentItem['createdAt'];
    isWriter = commentItem['me'];
  }

  late int id;
  late String content;
  late int writerId;
  late String writerName;
  late String writerProfileUrl;
  late int walkLogId; // 이건뭐징
  late String createdAt;
  late bool isWriter;
}
