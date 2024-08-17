import 'package:puppycode/apis/models/feed.dart';

class MyMontlyList {
  MyMontlyList(dynamic response) {
    year = response['year'];
    month = response['month'];
    nextYear = response['nextYear'];
    nextMonth = response['nextMonth'];
    count = response['count'];
    hasNext = response['hasNext'];

    List<dynamic> _items = response['items'];
    items = _items.map((item) => Feed(item)).toList();
  }

  late int year;
  late int month;
  late int nextYear;
  late int nextMonth;
  late int count;
  late List<Feed> items;
  late bool hasNext;
}
