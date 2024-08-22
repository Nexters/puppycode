class User {
  User(dynamic userItem) {
    id = userItem['id'];
    nickname = userItem['nickname'];
    profileImageUrl = userItem['profileImageUrl'] ?? '';
    code = userItem['code'];
    createdAt = userItem['createdAt'];
    walkDone = userItem['walkDone'];
    mainScreenImageUrl = userItem['mainScreenImageUrl'];
    location = userItem['location'];
  }

  late int id;
  late String profileImageUrl;
  late String nickname;
  late String code;
  late String createdAt;
  late String mainScreenImageUrl;
  late bool walkDone;
  late String location;
}
