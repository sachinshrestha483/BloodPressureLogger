import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mvp1/Utility/mathHelper.dart';
import 'package:mvp1/config/config.dart';
import 'package:mvp1/domain/bp_repository/src/bp_repository.dart';
import 'package:mvp1/domain/bp_repository/src/models/models.dart';
import 'package:mvp1/domain/reporting/enums/TimeRangeOfDay.dart';
import 'package:mvp1/domain/reporting/enums/days.dart';
import 'package:mvp1/pages/charts/view/pie_data.dart';
import 'package:mvp1/providers/userProvider.dart';
import 'package:mvp1/widgets/datefilter.dart';
import 'package:mvp1/widgets/daysAndTimeSelector.dart';
import 'package:mvp1/widgets/filters.dart';
import 'package:mvp1/widgets/userspecificappbar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
      drawer: Drawer(
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
            ListTile(
              title: const Text('Reminders'),
              onTap: () {
                // Update the state of the app.
                // ...
                Navigator.of(context).pushNamed(
                  '/remindersPage',
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
          Expanded(
            child: Consumer(
              builder: (context, watch, child) {
                final selectedProfileId = watch(selectedProfileProvider).state;
                return ValueListenableBuilder<Box<Bp>>(
                    valueListenable: BpRepository.GetBox().listenable(),
                    builder: (context, box, _) {
                      final readings = box.values
                          .toList()
                          .cast<Bp>()
                          .where(
                              (element) => element.userId == selectedProfileId)
                          .toList();
                      var bpChart = BpRepository.GetBpChart(
                          days, dayTimeRange, dateRange, readings);
                      return (bpChart != null)
                          ? Column(
                              children: [
                                Expanded(
                                  child: PieChart(
                                    PieChartData(
                                      borderData: FlBorderData(show: false),
                                      centerSpaceRadius: 80,
                                      sectionsSpace: 0,
                                      startDegreeOffset: 5,
                                      sections: GetPieChartSections(PieData.GetData(
                                          roundDouble(
                                              bpChart.normalReadingPercentage,
                                              1),
                                          roundDouble(
                                              bpChart
                                                  .stage1HypertensionReadingPercentage,
                                              1),
                                          roundDouble(
                                              bpChart
                                                  .stage2HypertensionReadingPercentage,
                                              1),
                                          roundDouble(
                                              bpChart
                                                  .stage3HypertensionReadingPercentage,
                                              1),
                                          roundDouble(
                                              bpChart.HypotensionPercentage,
                                              1))),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Text("No Data");
                    });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: Pallete.PieChartNormal,
                    ),
                    Text("Normal")
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: Pallete.PieChartStage1,
                    ),
                    Text("Stage 1 HyperTension ")
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: Pallete.PieChartStage2,
                    ),
                    Text("Stage 2 Hypertension")
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: Pallete.PieChartStage3,
                    ),
                    Text("Stage 3 HyperTension ")
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: Pallete.PieChartHypoTension,
                    ),
                    Text("Hypotension")
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
