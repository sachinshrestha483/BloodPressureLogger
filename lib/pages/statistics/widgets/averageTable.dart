import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:mvp1/Utility/dateTimeHelpers.dart';
import 'package:mvp1/config/config.dart';
import 'package:mvp1/domain/bp_repository/src/bp_repository.dart';
import 'package:mvp1/domain/bp_repository/src/models/models.dart';
import 'package:mvp1/domain/reporting/enums/TimeRangeOfDay.dart';
import 'package:mvp1/domain/reporting/enums/days.dart';
import 'package:mvp1/providers/userProvider.dart';
import 'package:mvp1/widgets/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget BuildAverageTable(
    DateTimeRange? dateRange, Days days, TimeRangeOfDay dayTimeRange) {
  return Consumer(builder: (context, watch, child) {
    final selectedProfileId = watch(selectedProfileProvider).state;

    return ValueListenableBuilder<Box<Bp>>(
      valueListenable: BpRepository.GetBox().listenable(),
      builder: (context, box, _) {
        final readings = box.values
            .toList()
            .cast<Bp>()
            .where((element) => element.userId == selectedProfileId)
            .toList();
        if (readings.length == 0) {
          return Text(
            "No Readings Found",
            style: AppTypography.PrimaryText,
          );
        }
        var minMaxaverageBp = BpRepository.getMinMaxAverageBpReadings(
            days, dayTimeRange, dateRange, readings);

        // if (averageBp == null) {
        //   return Column(
        //     children: [
        //       NoReadings(),
        //     ],
        //   );
        // }

        return !(readings.length == 0 || minMaxaverageBp == null)
            ? Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        BuildSafeText(
                            "${minMaxaverageBp.numberofReadings} readings (${ DateTimeHelpers.GetShortDate(minMaxaverageBp.startDate)} - ${ DateTimeHelpers.GetShortDate(minMaxaverageBp.endDate)  })",
                            AppTypography.TableInfo),
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Table(
                            columnWidths: const <int, TableColumnWidth>{
                              0: FlexColumnWidth(1.3),
                              1: FlexColumnWidth(),
                              2: FlexColumnWidth(),
                              3: FlexColumnWidth(),
                              4: FlexColumnWidth(),
                              5: FlexColumnWidth(),
                            },
                            children: [
                              TableRow(children: [
                                TableCell(
                                    child: Container(
                                  width: 40,
                                )),
                                TableCell(
                                    child: Container(
                                        width: 10,
                                        child: Text("Min",
                                            style: AppTypography.TableHeading,
                                            textAlign: TextAlign.center))),
                                TableCell(
                                    child: Container(
                                        width: 10,
                                        child: Text("Max",
                                            style: AppTypography.TableHeading,
                                            textAlign: TextAlign.center))),
                                TableCell(
                                    child: Container(
                                        width: 10,
                                        child: Text("Average",
                                            style: AppTypography.TableHeading,
                                            textAlign: TextAlign.center))),
                                TableCell(
                                    child: Container(
                                        width: 5,
                                        child: Text(
                                          "Vs Previous 30 days",
                                          style: AppTypography.TableHeading,
                                          textAlign: TextAlign.center,
                                        ))),
                              ]),
                              TableRow(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          top: BorderSide(
                                              width: 1,
                                              color: Pallete.GrayTextColor))),
                                  children: [
                                    TableCell(
                                        child: Padding(
                                      padding: const EdgeInsets.all(7.0),
                                      child: Container(
                                        width: 40,
                                        child: Text("Systolic",
                                            style: AppTypography.TableBody,
                                            textAlign: TextAlign.left),
                                      ),
                                    )),
                                    TableCell(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          width: 10,
                                          child: Text(
                                              " ${minMaxaverageBp.minSystolic}",
                                              style: AppTypography.TableBody,
                                              textAlign: TextAlign.center)),
                                    )),
                                    TableCell(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          width: 10,
                                          child: Text(
                                              " ${minMaxaverageBp.maxSystolic}",
                                              style: AppTypography.TableBody,
                                              textAlign: TextAlign.center)),
                                    )),
                                    TableCell(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          width: 10,
                                          child: Text(
                                              " ${minMaxaverageBp.avgSystolic}",
                                              style: AppTypography.TableBody,
                                              textAlign: TextAlign.center)),
                                    )),
                                    TableCell(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          width: 5,
                                          child: Text(
                                            "-",
                                            style: AppTypography.TableBody,
                                            textAlign: TextAlign.center,
                                          )),
                                    )),
                                  ]),
                              TableRow(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          top: BorderSide(
                                              width: 1,
                                              color: Pallete.GrayTextColor))),
                                  children: [
                                    TableCell(
                                        child: Padding(
                                      padding: const EdgeInsets.all(7.0),
                                      child: Container(
                                        width: 40,
                                        child: Text("Diastolic",
                                            style: AppTypography.TableBody,
                                            textAlign: TextAlign.left),
                                      ),
                                    )),
                                    TableCell(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          width: 10,
                                          child: Text(
                                              " ${minMaxaverageBp.minDiastolic}",
                                              style: AppTypography.TableBody,
                                              textAlign: TextAlign.center)),
                                    )),
                                    TableCell(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          width: 10,
                                          child: Text(
                                              " ${minMaxaverageBp.maxDiastolic}",
                                              style: AppTypography.TableBody,
                                              textAlign: TextAlign.center)),
                                    )),
                                    TableCell(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          width: 10,
                                          child: Text(
                                              " ${minMaxaverageBp.avgDiastolic}",
                                              style: AppTypography.TableBody,
                                              textAlign: TextAlign.center)),
                                    )),
                                    TableCell(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          width: 5,
                                          child: Text(
                                            "-",
                                            style: AppTypography.TableBody,
                                            textAlign: TextAlign.center,
                                          )),
                                    )),
                                  ]),
                              TableRow(
                                  decoration: BoxDecoration(
                                      border: Border(
                                          top: BorderSide(
                                              width: 1,
                                              color: Pallete.GrayTextColor))),
                                  children: [
                                    TableCell(
                                        child: Padding(
                                      padding: const EdgeInsets.all(7.0),
                                      child: Container(
                                        width: 40,
                                        child: Text("Pulse",
                                            style: AppTypography.TableBody,
                                            textAlign: TextAlign.left),
                                      ),
                                    )),
                                    TableCell(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          width: 10,
                                          child: Text(
                                              " ${minMaxaverageBp.minPulse}",
                                              style: AppTypography.TableBody,
                                              textAlign: TextAlign.center)),
                                    )),
                                    TableCell(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          width: 10,
                                          child: Text(
                                              " ${minMaxaverageBp.maxPulse}",
                                              style: AppTypography.TableBody,
                                              textAlign: TextAlign.center)),
                                    )),
                                    TableCell(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          width: 10,
                                          child: Text(
                                              " ${minMaxaverageBp.avgPulse}",
                                              style: AppTypography.TableBody,
                                              textAlign: TextAlign.center)),
                                    )),
                                    TableCell(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          width: 5,
                                          child: Text(
                                            "-",
                                            style: AppTypography.TableBody,
                                            textAlign: TextAlign.center,
                                          )),
                                    )),
                                  ]),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            : Text(
                "No Readings Found",
                style: AppTypography.PrimaryText,
              );
      },
    );
  });
}
