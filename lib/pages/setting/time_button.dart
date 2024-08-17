import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:puppycode/shared/styles/color.dart';

class SetWalkTimeButton extends StatefulWidget {
  const SetWalkTimeButton({
    super.key,
    required this.notificationEnabled,
  });

  final bool notificationEnabled;

  @override
  State<SetWalkTimeButton> createState() => _SetWalkTimeButtonState();
}

class _SetWalkTimeButtonState extends State<SetWalkTimeButton> {
  String time = DateFormat.jm().format(DateTime.now());
  GlobalKey buttonKey = GlobalKey();

  static String _formatTime(DateTime dateTime) {
    final hours = dateTime.hour % 12; // 12시간제
    final minutes = dateTime.minute.toString().padLeft(2, '0'); // 두 자리로 패딩
    final amPm = dateTime.hour >= 12 ? 'PM' : 'AM'; // AM/PM 구분
    return '${hours == 0 ? 12 : hours}:$minutes $amPm'; // 시간 포맷
  }

  DateTime _parseTime(String time) {
    final now = DateTime.now();
    final timeParts = time.split(RegExp(r'[:\s]'));
    final hour = int.parse(timeParts[0]) % 12 + (timeParts[2] == 'PM' ? 12 : 0);
    final minute = int.parse(timeParts[1]);

    return DateTime(now.year, now.month, now.day, hour, minute);
  }

  void onSetTime(BuildContext context, GlobalKey buttonKey) {
    final RenderBox button =
        buttonKey.currentContext!.findRenderObject() as RenderBox;
    final double buttonHeight = button.size.height;

    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(top: buttonHeight * 4, right: 20),
              child: Container(
                height: 213,
                width: 198,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: ThemeColor.white),
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.time,
                  initialDateTime: _parseTime(time),
                  onDateTimeChanged: (DateTime date) {
                    setState(() {
                      time = _formatTime(date);
                    });
                  },
                ),
              ),
            ),
          ],
        );
      },
      barrierDismissible: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: buttonKey,
      onPressed: () {
        if (widget.notificationEnabled) {
          onSetTime(context, buttonKey);
        }
      },
      style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 11),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          backgroundColor: const Color.fromRGBO(120, 120, 128, 0.12)),
      child: Text(
        time,
        style: const TextStyle(
            color: Colors.blue, fontSize: 17, fontWeight: FontWeight.w500),
      ),
    );
  }
}
