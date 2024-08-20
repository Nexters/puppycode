class Comment {
  Comment(dynamic commentItem) {
    id = commentItem['id'];
    content = commentItem['content'];
    writerName = commentItem['writerNickname'];
    writerProfileUrl = commentItem['writerProfileImageUrl'];
    walkLogId = commentItem['walkLogId'];
    createdAt = commentItem['createdAt'];
  }

  late int id;
  late String content;
  late String writerName;
  late String writerProfileUrl;
  late int walkLogId; // 이건뭐징
  late String createdAt;
}
