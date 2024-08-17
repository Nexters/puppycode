// ignore: constant_identifier_names

class Friend {
  Friend(dynamic item) {
    id = item['id'];
    name = item['nickname'];
    profileUrl = item['profileImageUrl'];
    hasWalked = item['done'] ?? false;
  }

  late int id;
  late String name;
  late String profileUrl;
  late bool hasWalked;
}
