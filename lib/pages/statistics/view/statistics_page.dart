import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mvp1/config/config.dart';
import 'package:mvp1/config/typography.dart';
import 'package:mvp1/domain/bp_repository/src/bp_repository.dart';
import 'package:mvp1/domain/bp_repository/src/models/models.dart';
import 'package:mvp1/domain/reporting/enums/TimeRangeOfDay.dart';
import 'package:mvp1/domain/reporting/enums/days.dart';
import 'package:mvp1/pages/analysis/widgets/noReadings.dart';
import 'package:mvp1/pages/statistics/widgets/averageHeading.dart';
import 'package:mvp1/pages/statistics/widgets/averageTable.dart';
import 'package:mvp1/providers/userProvider.dart';
import 'package:mvp1/widgets/filters.dart';
import 'package:mvp1/widgets/safetext.dart';
import 'package:mvp1/widgets/userspecificappbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({Key? key}) : super(key: key);

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
       drawer: 
      Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Bp Logger',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            ListTile(
              title: const Text('Export and Send'),
              onTap: () {
                // Update the state of the app.
                // ...
                Navigator.of(context).pushNamed(
                  '/exportandSend',
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Filters(
              onDateRangeChanged: SetDateTimeRange,
              onDaysAndDayTimeOfDayChange: SetDaysAndDayTimeRange),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                BuildAverageHeading(dateRange, days, dayTimeRange)
              ],
            ),
          ),
          Expanded(child: BuildAverageTable(dateRange, days, dayTimeRange)),
        ],
      ),
    );
  }
}
