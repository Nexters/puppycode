import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:puppycode/shared/app_bar.dart';
import 'package:puppycode/shared/banner.dart';
import 'package:puppycode/shared/nav_bar.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';
import 'package:puppycode/shared/typography/head.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  static const int maxMonth = 12;
  static const int minMonth = 1;

  int year = DateTime.now().year;
  int month = DateTime.now().month;
  bool isThisMonth = true;
  DateTime firstDayOfMonth =
      DateTime.utc(DateTime.now().year, DateTime.now().month, 1);
  DateTime lastDayOfMonth =
      DateTime.utc(DateTime.now().year, DateTime.now().month + 1, 0);

  void changeMonth(bool next) {
    if (isThisMonth && next) return;
    var relativeMonth = next ? month + 1 : month - 1;
    var nextMonth = (relativeMonth < minMonth)
        ? maxMonth
        : (relativeMonth > maxMonth)
            ? minMonth
            : relativeMonth;
    var isYearChanged = (nextMonth - month).abs() > 1;
    var nextYear =
        isYearChanged ? (month > nextMonth ? year + 1 : year - 1) : year;

    setState(() {
      _updateDays(nextYear, nextMonth);
    });
  }

  void _updateDays(int nextYear, int nextMonth) {
    isThisMonth = nextMonth == DateTime.now().month;
    firstDayOfMonth = DateTime.utc(nextYear, nextMonth, 1);
    lastDayOfMonth = DateTime.utc(nextYear, nextMonth + 1, 0);
    month = nextMonth;
    year = nextYear;
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
              onClick: () => {
                Get.toNamed('/', arguments: {'tab': NavTab.feed})
              },
              mainText: '친구의 산책 소식이 도착했어요',
              subText: '오늘은 어떤 산책이었을지 확인해볼까요?',
              iconName: 'folded_note',
            ),
            const SizedBox(height: 30),
            CalendarTable(
              month: month,
              firstDayOfMonth: firstDayOfMonth,
              lastDayOfMonth: lastDayOfMonth,
              onMonthClick: changeMonth,
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
    required this.onMonthClick,
  });

  final int month;
  final DateTime firstDayOfMonth;
  final DateTime lastDayOfMonth;
  final void Function(bool) onMonthClick;

  static const List<String> daysText = ['월', '화', '수', '목', '금', '토', '일'];
  static const List<int> days = [0, 1, 2, 3, 4, 5, 6];
  static const double cellPadding = 2;

  @override
  Widget build(BuildContext context) {
    var cellHeight =
        (MediaQuery.of(context).size.width - 40) / 7 - cellPadding * 2;
    var showMaxWeek =
        35 - firstDayOfMonth.weekday + 1 < lastDayOfMonth.day; // row 6개 보여야 할 때
    var isThisMonth = month == DateTime.now().month;

    return Column(
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
                    onTap: () => {onMonthClick(false)},
                    child: SvgPicture.asset('assets/icons/calendar_prev.svg')),
                const SizedBox(width: 8),
                GestureDetector(
                    onTap: () => {onMonthClick(true)},
                    child: isThisMonth
                        ? Opacity(
                            opacity: 0.4,
                            child: SvgPicture.asset(
                                'assets/icons/calendar_next.svg'))
                        : SvgPicture.asset('assets/icons/calendar_next.svg'))
              ],
            )
          ],
        ),
        const SizedBox(height: 20),
        Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              getWeekDaysTextRow(),
              getWeekRow(0, cellHeight, isThisMonth),
              getWeekRow(1, cellHeight, isThisMonth),
              getWeekRow(2, cellHeight, isThisMonth),
              getWeekRow(3, cellHeight, isThisMonth),
              getWeekRow(4, cellHeight, isThisMonth),
              if (showMaxWeek) getWeekRow(5, cellHeight, isThisMonth),
            ]),
        Container(
          margin: const EdgeInsets.only(top: 40),
          height: 170,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage('assets/images/pawpaw_puppy.png'))),
        )
      ],
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

  TableRow getWeekRow(int week, double cellHeight, bool isThisMonth) {
    var addedDate = 7 * week - firstDayOfMonth.weekday + 2;

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
        margin: const EdgeInsets.all(cellPadding),
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
