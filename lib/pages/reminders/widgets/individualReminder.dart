import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvp1/domain/reminder_repository/src/models/reminder_model.dart';

class IndividualReminder extends StatefulWidget {
  final Reminder reminder;
  const IndividualReminder({Key? key, required this.reminder})
      : super(key: key);
  @override
  _IndividualReminderState createState() => _IndividualReminderState(reminder);
}

class _IndividualReminderState extends State<IndividualReminder> {
  late Reminder reminder;
  _IndividualReminderState(Reminder _reminder) {
    reminder = _reminder;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12))),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(reminder.name),
                  Switch(
                      value: reminder.isactive,
                      onChanged: (value) {
                        setState(() {
                          reminder.isactive = value;
                          reminder.isactive = value;
                          reminder.save();
                        });
                      }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Frequency"),
                  Text("${reminder.time}"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Time"),
                  Text("${reminder.time}"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
