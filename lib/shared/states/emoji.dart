import 'package:get/get.dart';

class Emoji {
  final String emojiType;

  Emoji(this.emojiType);
}

class EmojiController extends GetxController {
  var emojis = <Emoji>[].obs;

  void addEmoji(String emojiType) {
    emojis.add(Emoji(emojiType));
  }
}
