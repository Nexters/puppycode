import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:puppycode/shared/app_bar.dart';
import 'package:puppycode/shared/banner.dart';
import 'package:puppycode/shared/http.dart';
import 'package:puppycode/shared/nav_bar.dart';
import 'package:puppycode/shared/styles/color.dart';
import 'package:puppycode/shared/typography/body.dart';
import 'package:puppycode/shared/typography/head.dart';
import 'package:puppycode/apis/models/feed.dart';

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
              iconName: 'news',
            ),
            const SizedBox(height: 30),
            CalendarTable(
              year: year,
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

class CalendarTable extends StatefulWidget {
  const CalendarTable({
    super.key,
    required this.year,
    required this.month,
    required this.firstDayOfMonth,
    required this.lastDayOfMonth,
    required this.onMonthClick,
  });

  final int year;
  final int month;
  final DateTime firstDayOfMonth;
  final DateTime lastDayOfMonth;
  final void Function(bool) onMonthClick;

  static const List<String> daysText = ['월', '화', '수', '목', '금', '토', '일'];
  static const List<int> days = [0, 1, 2, 3, 4, 5, 6];
  static const double cellPadding = 2;

  @override
  State<CalendarTable> createState() => _CalendarTableState();
}

class _CalendarTableState extends State<CalendarTable> {
  Map<String, Feed>? calendarItems;

  @override
  void initState() {
    _fetchCalendarData();
    super.initState();
  }

  Future<void> _fetchCalendarData() async {
    try {
      final response = await HttpService.getOne('walk-logs/calendar', params: {
        'year': widget.year.toString(),
        'month': widget.month.toString(),
        'userId': '1'
      });
      Map<String, dynamic> items = response['items'];
      setState(() {
        calendarItems =
            items.map((key, item) => MapEntry(key.split('-').last, Feed(item)));
      });
    } catch (error) {
      //print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    var cellHeight = (MediaQuery.of(context).size.width - 40) / 7 -
        CalendarTable.cellPadding * 2;
    var showMaxWeek = 35 - widget.firstDayOfMonth.weekday + 1 <
        widget.lastDayOfMonth.day; // row 6개 보여야 할 때
    var isThisMonth = widget.month == DateTime.now().month;

    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Head4(
              value: '${widget.month}월',
            )),
            Row(
              children: [
                GestureDetector(
                    onTap: () => {widget.onMonthClick(false)},
                    child: SvgPicture.asset('assets/icons/calendar_prev.svg')),
                const SizedBox(width: 8),
                GestureDetector(
                    onTap: () => {widget.onMonthClick(true)},
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
        children: CalendarTable.daysText
            .map((day) => Container(
                height: 26,
                margin: const EdgeInsets.only(bottom: 16),
                child: Center(
                    child: Body4(
                        value: day,
                        color: ThemeColor.gray4,
                        fontWeight: FontWeight.w400))))
            .toList());
  }

  TableRow getWeekRow(int week, double cellHeight, bool isThisMonth) {
    var addedDate = 7 * week - widget.firstDayOfMonth.weekday + 2;

    return TableRow(
        children: CalendarTable.days.map((day) {
      int cellDate = day + addedDate;
      bool isValidDate = cellDate > 0 && cellDate <= widget.lastDayOfMonth.day;
      int today = DateTime.now().day;
      bool isToday = isThisMonth && cellDate == today;
      bool isInFuture = isThisMonth && cellDate > today;
      Color textColor = isToday
          ? ThemeColor.white
          : (isInFuture ? ThemeColor.gray3 : ThemeColor.gray5);
      Feed? dateFeedItem =
          calendarItems != null ? calendarItems!['$cellDate'] : null;

      if (dateFeedItem == null) {
        return Container(
          height: cellHeight,
          margin: const EdgeInsets.all(CalendarTable.cellPadding),
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
      }

      return GestureDetector(
        onTap: () => {Get.toNamed('/feed/${dateFeedItem.id}')},
        child: Container(
          height: cellHeight,
          margin: const EdgeInsets.all(CalendarTable.cellPadding),
          decoration: BoxDecoration(
              color: isToday ? ThemeColor.primary : ThemeColor.gray2,
              borderRadius: BorderRadius.circular(20),
              image: isToday
                  ? null
                  : DecorationImage(
                      image: NetworkImage(dateFeedItem.photoUrl),
                      fit: BoxFit.cover)),
          child: Center(
            child: Body4(
              value: cellDate.toString(),
              fontWeight: FontWeight.w500,
              color: ThemeColor.white,
              textShadow: isToday
                  ? null
                  : Shadow(
                      blurRadius: 5,
                      color: ThemeColor.black.withOpacity(0.3),
                    ),
            ),
          ),
        ),
      );
    }).toList());
  }
}
