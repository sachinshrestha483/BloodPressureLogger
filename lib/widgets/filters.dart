import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:mvp1/domain/reporting/enums/TimeRangeOfDay.dart';
import 'package:mvp1/domain/reporting/enums/days.dart';
import 'package:mvp1/widgets/userspecificappbar.dart';

import 'datefilter.dart';
import 'daysAndTimeSelector.dart';

typedef void DateRangeVoidCallback(DateTimeRange? dateRange);
typedef void DaysandTimeofDayVoidCallback(
    Days days, TimeRangeOfDay timeRangeOfDay);

class Filters extends StatefulWidget {
  final DaysandTimeofDayVoidCallback onDaysAndDayTimeOfDayChange;
  final DateRangeVoidCallback onDateRangeChanged;

  const Filters(
      {Key? key,
      required this.onDateRangeChanged,
      required this.onDaysAndDayTimeOfDayChange})
      : super(key: key);

  @override
  _FiltersState createState() =>
      _FiltersState(onDaysAndDayTimeOfDayChange, onDateRangeChanged);
}

class _FiltersState extends State<Filters> {
  late DaysandTimeofDayVoidCallback onDayandTimeRangeOfDayChange;
  late DateRangeVoidCallback onDateRangeChanged;
  late bool ShowdateRangeFilter;
  _FiltersState(DaysandTimeofDayVoidCallback dayAndTimeOfDayCallBack,
      DateRangeVoidCallback dateRangeVoidCallback) {
    onDayandTimeRangeOfDayChange = dayAndTimeOfDayCallBack;
    onDateRangeChanged = dateRangeVoidCallback;
  }
  DateTimeRange? dateRange;

  Days days = Days.All_time;
  TimeRangeOfDay dayTimeRange = TimeRangeOfDay.Any_Time_of_Day;

  void SetDaysAndDayTimeRange(
      Days selectedDays, TimeRangeOfDay selectedDayTimeRange) {
    setState(() {
      dayTimeRange = selectedDayTimeRange;
      days = selectedDays;
      onDayandTimeRangeOfDayChange(days, dayTimeRange);
    });
  }

  void SetDateTimeRange(DateTimeRange? selecteddateRange) {
    setState(() {
      dateRange = selecteddateRange;
      onDateRangeChanged(selecteddateRange);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DaysandTimeSelector(
          onDaysAndDayTimeOfDayChange: SetDaysAndDayTimeRange,
        ),
        Visibility(
            visible: days == Days.custom,
            child: DateFilter(onDateRangeChanged: SetDateTimeRange)),
      ],
    );
  }
}
