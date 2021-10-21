import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mvp1/domain/reporting/enums/TimeRangeOfDay.dart';
import 'package:mvp1/domain/reporting/enums/days.dart';
import 'package:mvp1/widgets/datefilter.dart';
import 'package:mvp1/widgets/daysAndTimeSelector.dart';
import 'package:mvp1/widgets/filters.dart';
import 'package:mvp1/widgets/userspecificappbar.dart';

class ChartsPage extends StatefulWidget {
  const ChartsPage({Key? key}) : super(key: key);

  @override
  _ChartsPageState createState() => _ChartsPageState();
}

class _ChartsPageState extends State<ChartsPage> {
  DateTimeRange? dateRange;
  Days days = Days.All_time;
  TimeRangeOfDay dayTimeRange = TimeRangeOfDay.Any_Time_of_Day;
  void SetDaysAndDayTimeRange(
      Days selectedDays, TimeRangeOfDay selectedDayTimeRange) {
    setState(() {
      dayTimeRange = selectedDayTimeRange;
      days = selectedDays;
    });
  }

  void SetDateTimeRange(DateTimeRange? selecteddateRange) {
    setState(() {
      dateRange = selecteddateRange;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UserSpecificAppBar("Charts", context),
      body: Column(
        children: [
          Filters(
              onDateRangeChanged: SetDateTimeRange,
              onDaysAndDayTimeOfDayChange: SetDaysAndDayTimeRange),
          Text("In the Body of The App Date Range: ${dateRange}"),
          Text("In the Body of The App  Days : ${days}"),
          Text("In the Body of The App  DayTimeRange : ${dayTimeRange}"),
          Text("Dummy Filter"),
        ],
      ),
    );
  }
}
