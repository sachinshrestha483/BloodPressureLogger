import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:mvp1/Utility/dateTimeHelpers.dart';
import 'package:mvp1/domain/bp_repository/src/bp_repository.dart';
import 'package:mvp1/domain/bp_repository/src/models/bp_chartmodel.dart';
import 'package:mvp1/domain/bp_repository/src/models/bp_reportmodel.dart';
import 'package:mvp1/domain/bp_repository/src/models/models.dart';
import 'package:mvp1/domain/reporting/enums/TimeRangeOfDay.dart';
import 'package:mvp1/domain/reporting/enums/days.dart';
import 'package:mvp1/domain/reporting/pdf_api.dart';
import 'package:mvp1/domain/reporting/pdfreportapi.dart';
import 'package:mvp1/domain/user_repository/src/user_repository.dart';
import 'package:mvp1/providers/userProvider.dart';
import 'package:mvp1/widgets/buttons.dart';
import 'package:mvp1/widgets/filters.dart';
import 'package:mvp1/widgets/userspecificappbar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ExportandSend extends StatefulWidget {
  const ExportandSend({Key? key}) : super(key: key);

  @override
  _ExportandSendState createState() => _ExportandSendState();
}

class _ExportandSendState extends State<ExportandSend> {
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
      appBar: UserSpecificAppBar("Export and Send", context),
      body: Column(children: [
        Filters(
            onDateRangeChanged: SetDateTimeRange,
            onDaysAndDayTimeOfDayChange: SetDaysAndDayTimeRange),
        SizedBox(
          height: 12,
        ),
        Consumer(
          builder: (BuildContext context,
              T Function<T>(ProviderBase<Object?, T>) watch, Widget? child) {
            final selectedProfileId = watch(selectedProfileProvider).state;

            return ValueListenableBuilder<Box<Bp>>(
                valueListenable: BpRepository.GetBox().listenable(),
                builder: (context, box, _) {
                  final readings = box.values
                      .toList()
                      .cast<Bp>()
                      .where((element) => element.userId == selectedProfileId)
                      .toList();

                  var filteredReadings = readings;
                  filteredReadings.sort((a, b) {
                    if (a.readingDateTime.isAfter(b.readingDateTime)) {
                      return 1;
                    }
                    return 0;
                  });
                  var bpReport = new BpReport();
                  if (filteredReadings.length > 0) {
                    bpReport.user = UserRepository.GetUser(selectedProfileId);

                    var bpChartData = BpRepository.GetBpChart(
                        days, dayTimeRange, dateRange, filteredReadings);
                    var minMaxAverageBpReading =
                        BpRepository.getMinMaxAverageBpReadings(
                            days, dayTimeRange, dateRange, readings);

                    if (bpChartData == null || minMaxAverageBpReading == null) {
                      return Text("No Data");
                    }
                    bpReport.bpChartData = bpChartData;
                    bpReport.minMaxAverageBpReading = minMaxAverageBpReading;
                    bpReport.readings = filteredReadings;
                    bpReport.timeRangeOfDay = dayTimeRange;
                  }
                  return (filteredReadings.length > 0)
                      ? Column(
                          children: [
                            Text(
                                "${filteredReadings.length} readings (${DateTimeHelpers.GetShortDate(filteredReadings.first.readingDateTime)} - ${DateTimeHelpers.GetShortDate(filteredReadings.last.readingDateTime)})"),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                BuildPrimaryButton(() async {
                                  var PdfFile =
                                      await PdfReportApi.generate(bpReport);
                                  PdfApi.openFile(PdfFile);

                                }, Text("Preview Pdf")),
                                BuildPrimaryButton(() async {
                                  var bpChartData = new BpChartData();
                                  var PdfFile =
                                      await PdfReportApi.generate(bpReport);
                                  PdfApi.shareFile(PdfFile);
                                }, Text("Export Pdf")),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                          ],
                        )
                      : Text("No Data in Given Date Range");
                });
          },
        )
      ]),
    );
  }
}
