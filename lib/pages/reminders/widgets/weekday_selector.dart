import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

typedef void WeekDaySelectorCallback(bool monday, bool tuesday, bool wednesday,
    bool thursday, bool friday, bool saturday, bool sunday);

class WeekDaySelector extends StatefulWidget {
  final WeekDaySelectorCallback weekDaySelectorCallBack;
  const WeekDaySelector({Key? key, required this.weekDaySelectorCallBack})
      : super(key: key);
  @override
  _WeekDaySelectorState createState() =>
      _WeekDaySelectorState(weekDaySelectorCallBack);
}

class _WeekDaySelectorState extends State<WeekDaySelector> {
  bool monday = true;
  bool tuesday = true;
  bool wednesday = true;
  bool thursday = true;
  bool friday = true;
  bool saturday = true;
  bool sunday = true;

  late WeekDaySelectorCallback setWeekDays;
  _WeekDaySelectorState(WeekDaySelectorCallback weekDaySelectorCallback) {
    setWeekDays = weekDaySelectorCallback;
  }

  void checkWeekDay() {
    setWeekDays(sunday,monday, tuesday, wednesday, thursday, friday, saturday);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                checkColor: Colors.white,
                value: monday,
                onChanged: (bool? value) {
                  setState(() {
                    monday = value!;
                    checkWeekDay();
                  });
                },
              ),
              Text("Monday "),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                checkColor: Colors.white,
                value: tuesday,
                onChanged: (bool? value) {
                  setState(() {
                    tuesday = value!;
                    checkWeekDay();
                  });
                },
              ),
              Text("Tuesday "),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                checkColor: Colors.white,
                value: wednesday,
                onChanged: (bool? value) {
                  setState(() {
                    wednesday = value!;
                    checkWeekDay();
                  });
                },
              ),
              Text("Wednesday "),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                checkColor: Colors.white,
                value: thursday,
                onChanged: (bool? value) {
                  setState(() {
                    thursday = value!;
                    checkWeekDay();
                  });
                },
              ),
              Text("Thursday "),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                checkColor: Colors.white,
                value: friday,
                onChanged: (bool? value) {
                  setState(() {
                    friday = value!;
                    checkWeekDay();
                  });
                },
              ),
              Text("Friday "),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                checkColor: Colors.white,
                value: saturday,
                onChanged: (bool? value) {
                  setState(() {
                    saturday = value!;
                    checkWeekDay();
                  });
                },
              ),
              Text("Saturday "),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                checkColor: Colors.white,
                value: sunday,
                onChanged: (bool? value) {
                  setState(() {
                    sunday = value!;
                    checkWeekDay();
                  });
                },
              ),
              Text("Sunday "),
            ],
          ),
        ],
      ),
    );
  }
}
