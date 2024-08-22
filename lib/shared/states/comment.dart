import 'package:get/get.dart';

class Comment {
  final String text;

  Comment(this.text);
}

class CommentController extends GetxController {
  var comments = <Comment>[].obs;

  void addEmoji(String emojiType) {
    comments.add(Comment(emojiType));
  }
}
