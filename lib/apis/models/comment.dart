class Comment {
  Comment(dynamic commentItem) {
    id = commentItem['id'];
    content = commentItem['content'];
    writerId = commentItem['writerId']; // 댓글 작성자 아이디
    writerName = commentItem['writerNickname'];
    writerProfileUrl = commentItem['writerProfileImageUrl'];
    walkLogId = commentItem['walkLogId'];
    createdAt = commentItem['createdAt'];
    isWriter = commentItem['me']; // 댓글 작성자
  }

  late int id;
  late String content;
  late int writerId;
  late String writerName;
  late String writerProfileUrl;
  late int walkLogId;
  late String createdAt;
  late bool isWriter;
}
