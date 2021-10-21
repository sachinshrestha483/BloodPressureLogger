import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:mvp1/domain/reporting/enums/TimeRangeOfDay.dart';
import 'package:mvp1/domain/reporting/enums/days.dart';

// This is Just For Type Safety Of The Function Nothing else Can use  the function as well
typedef void DateRangeVoidCallback(DateTimeRange? dateRange);
typedef void DaysandTimeofDayVoidCallback(
    Days days, TimeRangeOfDay timeRangeOfDay);


class DateFilter extends StatefulWidget {
  final DateRangeVoidCallback onDateRangeChanged;
  DateFilter({Key? key, required this.onDateRangeChanged}) : super(key: key);

  @override
  _DateFilterState createState() => _DateFilterState(onDateRangeChanged);
}

class _DateFilterState extends State<DateFilter> {
  DateTimeRange? dateRange;
  Days days=Days.All_time;
  TimeRangeOfDay timeRangeOfday=TimeRangeOfDay.Any_Time_of_Day;
  late DateRangeVoidCallback onDateRangeChanged;

  _DateFilterState(DateRangeVoidCallback callback) {
    onDateRangeChanged = callback;
  }

  String getFrom() {
    if (dateRange == null) {
      return "Start Date";
    } else {
      return DateFormat('dd/MM/yyyy').format(dateRange!.start);
    }
  }

  String getUntil() {
    if (dateRange == null) {
      return 'End Date';
    } else {
      return DateFormat('dd/MM/yyyy').format(dateRange!.end);
    }
  }

  DateTimeRange? GetSelectedDateTimeRange() {
    return dateRange;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                pickDateRange(context);
              },
              child: Text(getFrom())),
              SizedBox(width: 15,),
          ElevatedButton(
              onPressed: () {
                pickDateRange(context);
              },
              child: Text(getUntil())),
        ],
      ),
    );
  }

  Future pickDateRange(BuildContext context) async {
    final initialDateRange = DateTimeRange(
      start: DateTime.now(),
      end: DateTime.now().add(Duration(hours: 24 * 3)),
    );
    final newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      initialDateRange: dateRange ?? initialDateRange,
    );

    if (newDateRange == null) return;

    setState(() => dateRange = newDateRange);
    onDateRangeChanged(newDateRange);
  }
}
