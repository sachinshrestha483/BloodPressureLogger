import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:mvp1/domain/reporting/enums/TimeRangeOfDay.dart';
import 'package:mvp1/domain/reporting/enums/days.dart';
import 'package:mvp1/widgets/filters.dart';
import 'package:mvp1/widgets/userspecificappbar.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({ Key? key }) : super(key: key);

  @override
  _StatisticsPageState createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
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
      appBar: UserSpecificAppBar("Statistics", context),
    body: Column(
        children: [
          Filters(
              onDateRangeChanged: SetDateTimeRange,
              onDaysAndDayTimeOfDayChange: SetDaysAndDayTimeRange),
              SizedBox(height: 15,),
              


          
        ],
      ),

      
    );
  }
}