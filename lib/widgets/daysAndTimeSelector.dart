import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mvp1/domain/reporting/enums/TimeRangeOfDay.dart';
import 'package:mvp1/domain/reporting/enums/days.dart';
import 'package:mvp1/domain/reporting/enums/enumHelper.dart';

typedef void DaysandTimeofDayVoidCallback(
    Days days, TimeRangeOfDay timeRangeOfDay);

class DaysandTimeSelector extends StatefulWidget {
  final DaysandTimeofDayVoidCallback onDaysAndDayTimeOfDayChange;

  DaysandTimeSelector({Key? key, required this.onDaysAndDayTimeOfDayChange})
      : super(key: key);

  @override
  _DaysandTimeSelectorState createState() =>
      _DaysandTimeSelectorState(onDaysAndDayTimeOfDayChange);
}

class _DaysandTimeSelectorState extends State<DaysandTimeSelector> {
  late Days days = Days.All_time;
  late TimeRangeOfDay timeRange = TimeRangeOfDay.Any_Time_of_Day;
  late DaysandTimeofDayVoidCallback onDayandTimeRangeOfDayChange;

  _DaysandTimeSelectorState(
      DaysandTimeofDayVoidCallback dayandTimeRangeCallBack) {
    onDayandTimeRangeOfDayChange = dayandTimeRangeCallBack;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: DropdownButton<Days>(
              value: days,
              onChanged: (newValue) {
                setState(() {
                  print("Changing The Gender Value");
                  print(newValue!.index.toString());
                  days = newValue;
                  onDayandTimeRangeOfDayChange(days, timeRange);
                  print("days ${days}");
                  //gender = newValue!.index;
                });
              },
              items: Days.values.map((Days days) {
                return DropdownMenuItem<Days>(
                    value: days,
                    child: Text(DaysEnumHelper.GetDisPlayString(days)));
              }).toList()),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: DropdownButton<TimeRangeOfDay>(
              value: timeRange,
              onChanged: (newValue) {
                setState(() {
                  print("Changing The Gender Value");
                  print(newValue!.index.toString());
                  timeRange = newValue;
                  print("Gender ${timeRange}");
                  onDayandTimeRangeOfDayChange(days, timeRange);

                  //gender = newValue!.index;
                });
              },
              items: TimeRangeOfDay.values.map((TimeRangeOfDay timeRangeOfDay) {
                return DropdownMenuItem<TimeRangeOfDay>(
                    value: timeRangeOfDay,
                    child: Text(TimeRangeOfDayEnumHelper.GetDisPlayString(
                        timeRangeOfDay)));
              }).toList()),
        ),
      ],
    );
  }
}
