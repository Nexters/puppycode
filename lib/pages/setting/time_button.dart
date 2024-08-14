import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SetWalkTimeButton extends StatefulWidget {
  const SetWalkTimeButton({
    super.key,
    required this.buttonEnabled,
  });

  final bool buttonEnabled;

  @override
  State<SetWalkTimeButton> createState() => _SetWalkTimeButtonState();
}

class _SetWalkTimeButtonState extends State<SetWalkTimeButton> {
  String time = DateFormat.jm().format(DateTime.now());
  GlobalKey buttonKey = GlobalKey();

  DateTime _parseTime(String time) {
    final now = DateTime.now();
    final format = DateFormat.jm();
    final DateTime date = format.parse(time);

    return DateTime(now.year, now.month, now.day, date.hour, date.minute);
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
                    color: Colors.white),
                child: CupertinoDatePicker(
                  //use24hFormat: true,
                  mode: CupertinoDatePickerMode.time,
                  initialDateTime: _parseTime(time),
                  onDateTimeChanged: (DateTime date) {
                    setState(() {
                      time = DateFormat.jm().format(date);
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
        if (widget.buttonEnabled) {
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
