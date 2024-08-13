import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:puppycode/shared/app_bar.dart';
import 'package:puppycode/shared/banner.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';
import 'package:puppycode/shared/typography/head.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  String? focusedUserId;
  int month = DateTime.now().month;
  DateTime firstDayOfMonth =
      DateTime.utc(DateTime.now().year, DateTime.now().month, 1);
  DateTime lastDayOfMonth =
      DateTime.utc(DateTime.now().year, DateTime.now().month + 1, 0);

  void setFocusUser(String? userId) {
    setState(() {
      focusedUserId = focusedUserId == userId ? null : userId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SharedAppBar(
        leftOptions: AppBarLeft(),
        centerOptions: AppBarCenter(label: '산책 캘린더'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: Column(
          children: [
            SharedBanner(
              onClick: () => {},
              mainText: '친구의 산책 소식이 도착했어요',
              subText: '오늘은 어떤 산책이었을지 확인해볼까요?',
            ),
            const SizedBox(height: 30),
            CalendarTable(
              month: month,
              firstDayOfMonth: firstDayOfMonth,
              lastDayOfMonth: lastDayOfMonth,
            )
          ],
        ),
      ),
    );
  }
}

class CalendarTable extends StatelessWidget {
  const CalendarTable({
    super.key,
    required this.month,
    required this.firstDayOfMonth,
    required this.lastDayOfMonth,
  });

  final int month;
  final DateTime firstDayOfMonth;
  final DateTime lastDayOfMonth;

  static List<String> daysText = ['월', '화', '수', '목', '금', '토', '일'];
  static List<int> days = [0, 1, 2, 3, 4, 5, 6];

  @override
  Widget build(BuildContext context) {
    var cellHeight = (MediaQuery.of(context).size.width - 40) / 7 - 4;

    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Head4(
                value: '$month월',
              )),
              Row(
                children: [
                  GestureDetector(
                      child:
                          SvgPicture.asset('assets/icons/calendar_prev.svg')),
                  const SizedBox(width: 8),
                  GestureDetector(
                      child: SvgPicture.asset('assets/icons/calendar_next.svg'))
                ],
              )
            ],
          ),
          const SizedBox(height: 20),
          Container(
            child: Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  getWeekDaysTextRow(),
                  getWeekRow(0, cellHeight),
                  getWeekRow(1, cellHeight),
                  getWeekRow(2, cellHeight),
                  getWeekRow(3, cellHeight),
                  getWeekRow(4, cellHeight),
                ]),
          )
        ],
      ),
    );
  }

  TableRow getWeekDaysTextRow() {
    return TableRow(
        children: daysText
            .map((day) => Container(
                height: 26,
                margin: const EdgeInsets.only(bottom: 16),
                child: Center(
                    child: Body4(
                        value: day,
                        color: ThemeColor.gray4,
                        fontWeight: FontWeight.w500))))
            .toList());
  }

  TableRow getWeekRow(int week, double cellHeight) {
    var addedDate = 7 * week - firstDayOfMonth.weekday + 2;
    var isThisMonth = month == DateTime.now().month;

    return TableRow(
        children: days.map((day) {
      var cellDate = day + addedDate;
      var isValidDate = cellDate > 0 && cellDate <= lastDayOfMonth.day;
      var today = DateTime.now().day;
      var isToday = isThisMonth && cellDate == today;
      var isInFuture = isThisMonth && cellDate > today;
      var textColor = isToday
          ? ThemeColor.white
          : (isInFuture ? ThemeColor.gray3 : ThemeColor.gray5);

      return Container(
        height: cellHeight,
        margin: const EdgeInsets.all(2),
        decoration: isValidDate
            ? BoxDecoration(
                color: isToday ? ThemeColor.primary : ThemeColor.gray2,
                borderRadius: BorderRadius.circular(20),
              )
            : null,
        child: Center(
          child: Body4(
            value: (isValidDate ? cellDate : '').toString(),
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
      );
    }).toList());
  }
}
