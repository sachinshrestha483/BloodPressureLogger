import 'dart:io';
import 'package:mvp1/Utility/dateTimeHelpers.dart';
import 'package:mvp1/config/config.dart';
import 'package:mvp1/domain/bp_repository/src/StandardBpUnits.dart';
import 'package:mvp1/domain/bp_repository/src/models/bp_chartmodel.dart';
import 'package:mvp1/domain/bp_repository/src/models/bp_reportmodel.dart';
import 'package:mvp1/domain/reporting/enums/enumHelper.dart';
import 'package:mvp1/domain/reporting/pdf_api.dart';
import 'package:mvp1/domain/user_repository/src/enums/gender.dart';
import 'package:mvp1/domain/user_repository/src/user_repository.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'enums/enumHelper.dart';

class PdfReportApi {
  // var myFont = pw.Font.ttf();

  static Future<File> generate(BpReport bpReport) {
    final pdf = pw.Document();

    pdf.addPage(pw.MultiPage(
        build: (context) => [
              buildTitle(bpReport),
              pw.SizedBox(
                height: 2 * PdfPageFormat.cm,
              ),
              buildUserInfoSection(bpReport),
              pw.SizedBox(
                height: 0.8 * PdfPageFormat.cm,
              ),
              buildDivider(),
              pw.SizedBox(
                height: 0.8 * PdfPageFormat.cm,
              ),
              buildEntryTable(bpReport),
              pw.SizedBox(
                height: 0.8 * PdfPageFormat.cm,
              ),
              buildSummary(bpReport)
            ]));

    return PdfApi.saveDocument(name: "BpReport", pdf: pdf);
  }

  static buildTitle(BpReport bpReport) {
    return pw.Column(
      children: [
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
          pw.Text("Blood Pressure Report ",
              style: pw.TextStyle(fontSize: 28, fontWeight: pw.FontWeight.bold),
              textAlign: pw.TextAlign.center),
        ]),
      ],
    );
  }

  static buildDivider() {
    return pw.Divider(
      thickness: 1,
    );
  }

  static buildBody(BpReport bpReport) {
    return pw.Column(children: []);
  }

  static buildEntryTable(BpReport bpReport) {
    return pw.Column(children: [
      pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        child: pw.Row(children: [
          pw.Expanded(
              child: pw.Container(
                  decoration: pw.BoxDecoration(border: pw.Border.all()),
                  child: pw.Padding(
                    padding: pw.EdgeInsets.all(4),
                    child: pw.SizedBox(
                        child:
                            pw.Text(" Date", textAlign: pw.TextAlign.center)),
                  )),
              flex: 3),
          pw.Expanded(
              child: pw.Container(
                  decoration: pw.BoxDecoration(border: pw.Border.all()),
                  child: pw.Padding(
                    padding: pw.EdgeInsets.all(4),
                    child: pw.SizedBox(
                        child: pw.Text("Time", textAlign: pw.TextAlign.center)),
                  )),
              flex: 2),
          pw.Expanded(
              child: pw.Container(
                  decoration: pw.BoxDecoration(border: pw.Border.all()),
                  child: pw.Padding(
                    padding: pw.EdgeInsets.all(4),
                    child: pw.SizedBox(
                        child: pw.Text("Systolic",
                            textAlign: pw.TextAlign.center)),
                  )),
              flex: 2),
          pw.Expanded(
              child: pw.Container(
                  decoration: pw.BoxDecoration(border: pw.Border.all()),
                  child: pw.Padding(
                    padding: pw.EdgeInsets.all(4),
                    child: pw.SizedBox(
                        child: pw.Text("Diastolic",
                            textAlign: pw.TextAlign.center)),
                  )),
              flex: 2),
          pw.Expanded(
              child: pw.Container(
                  decoration: pw.BoxDecoration(border: pw.Border.all()),
                  child: pw.Padding(
                    padding: pw.EdgeInsets.all(4),
                    child: pw.SizedBox(
                        child:
                            pw.Text("Pulse", textAlign: pw.TextAlign.center)),
                  )),
              flex: 2),
          pw.Expanded(
              child: pw.Container(
                  decoration: pw.BoxDecoration(border: pw.Border.all()),
                  child: pw.Padding(
                    padding: pw.EdgeInsets.all(4),
                    child: pw.SizedBox(
                        child: pw.Text("Note", textAlign: pw.TextAlign.center)),
                  )),
              flex: 7),
        ]),
      ),
      ...buildTableBody(bpReport)
    ]);

    //  pw.Table(
    //     border: pw.TableBorder.all(width: 2),
    //     defaultColumnWidth: pw.FixedColumnWidth(190.0),
    //     children: [
    //       pw.TableRow(children: [
    //         pw.Column(children: [
    //           pw.Text('Date', style: pw.TextStyle(fontSize: 15.0))
    //         ]),
    //         pw.Column(children: [
    //           pw.Text('Time', style: pw.TextStyle(fontSize: 15.0))
    //         ]),
    //         pw.Column(children: [
    //           pw.Text('Systolic', style: pw.TextStyle(fontSize: 15.0))
    //         ]),
    //         pw.Column(children: [
    //           pw.Text('Diastolic', style: pw.TextStyle(fontSize: 15.0))
    //         ]),
    //         pw.Column(children: [
    //           pw.Text('Pulse', style: pw.TextStyle(fontSize: 15.0))
    //         ]),
    //         pw.Column(children: [
    //           pw.Text('Note', style: pw.TextStyle(fontSize: 15.0))
    //         ]),
    //       ]),
    //       ...buildTableBody(bpReport)
    //     ]);
  }

  static List<pw.Container> buildTableBody(BpReport bpReport) {
    var rows = <pw.Container>[];
    for (int i = 0; i < bpReport.readings.length; i++) {
      var row = pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        child: pw.Row(children: [
          pw.Expanded(
              child: pw.Container(
                  decoration: pw.BoxDecoration(border: pw.Border.all()),
                  child: pw.Padding(
                    padding: pw.EdgeInsets.all(0),
                    child: pw.SizedBox(
                        child: pw.Text(
                            '${DateTimeHelpers.GetShortDate(bpReport.readings[i].readingDateTime)}  ',
                            textAlign: pw.TextAlign.center)),
                  )),
              flex: 3),
          pw.Expanded(
              child: pw.Container(
                  decoration: pw.BoxDecoration(
                      border: pw.Border(
                    left: pw.BorderSide(),
                    right: pw.BorderSide(),
                    bottom: pw.BorderSide(width: 0),
                    top: pw.BorderSide(width: 0),
                  )),
                  child: pw.Padding(
                    padding: pw.EdgeInsets.all(0),
                    child: pw.SizedBox(
                        child: pw.Text(
                            ' ${DateTimeHelpers.GetShortTime(bpReport.readings[i].readingDateTime)} ',
                            textAlign: pw.TextAlign.center)),
                  )),
              flex: 2),
          pw.Expanded(
              child: pw.Container(
                  decoration: pw.BoxDecoration(
                      border: pw.Border(
                    left: pw.BorderSide(),
                    right: pw.BorderSide(),
                    bottom: pw.BorderSide(width: 0),
                    top: pw.BorderSide(width: 0),
                  )),
                  child: pw.Padding(
                    padding: pw.EdgeInsets.all(0),
                    child: pw.SizedBox(
                        child: pw.Text('${bpReport.readings[i].systolic}',
                            textAlign: pw.TextAlign.center)),
                  )),
              flex: 2),
          pw.Expanded(
              child: pw.Container(
                  decoration: pw.BoxDecoration(
                      border: pw.Border(
                    left: pw.BorderSide(),
                    right: pw.BorderSide(),
                    bottom: pw.BorderSide(width: 0),
                    top: pw.BorderSide(width: 0),
                  )),
                  child: pw.Padding(
                    padding: pw.EdgeInsets.all(0),
                    child: pw.SizedBox(
                        child: pw.Text("${bpReport.readings[i].diastolic}",
                            textAlign: pw.TextAlign.center)),
                  )),
              flex: 2),
          pw.Expanded(
              child: pw.Container(
                  decoration: pw.BoxDecoration(
                      border: pw.Border(
                    left: pw.BorderSide(),
                    right: pw.BorderSide(),
                    bottom: pw.BorderSide(width: 0),
                    top: pw.BorderSide(width: 0),
                  )),
                  child: pw.Padding(
                    padding: pw.EdgeInsets.all(0),
                    child: pw.SizedBox(
                        child: pw.Text("${bpReport.readings[i].pulse}",
                            textAlign: pw.TextAlign.center)),
                  )),
              flex: 2),
          pw.Expanded(
              child: pw.Container(
                  decoration: pw.BoxDecoration(
                      border: pw.Border(
                    left: pw.BorderSide(),
                    right: pw.BorderSide(),
                    bottom: pw.BorderSide(width: 0),
                    top: pw.BorderSide(width: 0),
                  )),
                  child: pw.Padding(
                    padding: pw.EdgeInsets.all(0),
                    child: pw.SizedBox(
                        child: pw.Text(
                            "${(bpReport.readings[i].note.trim() == "") ? "-" : bpReport.readings[i].note.trim()}",
                            textAlign: pw.TextAlign.center)),
                  )),
              flex: 7),
        ]),
      );
      rows.add(row);
    }
    return rows;
  }

  static buildUserInfoSection(BpReport bpReport) {
    return pw.Column(children: [
      pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
        pw.Text("Name: ${bpReport.user.name}",
            style: pw.TextStyle(fontSize: 12)),
        pw.Text(
            "Date Range: ${DateTimeHelpers.GetShortDate(bpReport.readings.first.readingDateTime)} - ${DateTimeHelpers.GetShortDate(bpReport.readings.last.readingDateTime)}",
            style: pw.TextStyle(fontSize: 12)),
      ]),
      pw.SizedBox(
        height: 0.2 * PdfPageFormat.cm,
      ),
      pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
        pw.Text(
            "Gender:  ${UserRepository.GetGenderDisplayString(Gender.values[bpReport.user.gender])} ",
            style: pw.TextStyle(fontSize: 12)),
        pw.Text("Age: ${bpReport.user.age}", style: pw.TextStyle(fontSize: 12)),
        pw.Text("Number Of Readings: ${bpReport.readings.length}",
            style: pw.TextStyle(fontSize: 12)),
      ]),
      pw.SizedBox(
        height: 0.2 * PdfPageFormat.cm,
      ),
      pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
        pw.Text(
            "Reading Type:  ${TimeRangeOfDayEnumHelper.GetDisPlayString(bpReport.timeRangeOfDay)} ",
            style: pw.TextStyle(fontSize: 12)),
      ])
    ]);
  }

  static buildSummary(BpReport bpReport) {
    return buildSummaryTable(bpReport);
  }

  static buildSummaryTable(BpReport bpReport) {
    return pw.Column(children: [
      pw.Text(
        "Summary",
        style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold),
      ),
      pw.SizedBox(
        height: 0.2 * PdfPageFormat.cm,
      ),
      pw.Container(
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        child: pw.Row(children: [
          pw.Expanded(
              child: pw.Container(
                  decoration: pw.BoxDecoration(border: pw.Border.all()),
                  child: pw.Padding(
                    padding: pw.EdgeInsets.all(4),
                    child: pw.SizedBox(
                        child: pw.Text(" -  ", textAlign: pw.TextAlign.center)),
                  )),
              flex: 4),
          pw.Expanded(
              child: pw.Container(
                  decoration: pw.BoxDecoration(border: pw.Border.all()),
                  child: pw.Padding(
                    padding: pw.EdgeInsets.all(4),
                    child: pw.SizedBox(
                        child:
                            pw.Text("Minimum", textAlign: pw.TextAlign.center)),
                  )),
              flex: 2),
          pw.Expanded(
              child: pw.Container(
                  decoration: pw.BoxDecoration(border: pw.Border.all()),
                  child: pw.Padding(
                    padding: pw.EdgeInsets.all(4),
                    child: pw.SizedBox(
                        child:
                            pw.Text("Maximum", textAlign: pw.TextAlign.center)),
                  )),
              flex: 2),
          pw.Expanded(
              child: pw.Container(
                  decoration: pw.BoxDecoration(border: pw.Border.all()),
                  child: pw.Padding(
                    padding: pw.EdgeInsets.all(4),
                    child: pw.SizedBox(
                        child:
                            pw.Text("Average", textAlign: pw.TextAlign.center)),
                  )),
              flex: 2),
          pw.Expanded(
              child: pw.Container(
                  decoration: pw.BoxDecoration(border: pw.Border.all()),
                  child: pw.Padding(
                    padding: pw.EdgeInsets.all(4),
                    child: pw.SizedBox(
                        child: pw.Text("Refrence Range",
                            textAlign: pw.TextAlign.center)),
                  )),
              flex: 3),

          // pw.Expanded(
          //     child: pw.SizedBox(
          //         child: pw.Text("Maximum", textAlign: pw.TextAlign.center)),
          //     flex: 2),
          // pw.Expanded(
          //     child: pw.SizedBox(
          //         child: pw.Text("Average", textAlign: pw.TextAlign.center)),
          //     flex: 2),
          // pw.Expanded(
          //     child: pw.SizedBox(
          //         child: pw.Text("Refrence Range",
          //             textAlign: pw.TextAlign.center)),
          //     flex: 3),
        ]),
      ),
      pw.Container(
          decoration: pw.BoxDecoration(border: pw.Border.all()),
          child: pw.Padding(
            padding: pw.EdgeInsets.all(0),
            child: pw.Row(children: [
              pw.Expanded(
                  child: pw.Container(
                    decoration: pw.BoxDecoration(border: pw.Border.all()),
                    child: pw.Padding(
                        padding: pw.EdgeInsets.all(4),
                        child: pw.SizedBox(child: pw.Text("Systolic (mmHg)"))),
                  ),
                  flex: 4),
              pw.Expanded(
                  child: pw.Container(
                    decoration: pw.BoxDecoration(border: pw.Border.all()),
                    child: pw.Padding(
                        padding: pw.EdgeInsets.all(4),
                        child: pw.SizedBox(
                            child: pw.Text(
                                "${bpReport.minMaxAverageBpReading.minSystolic}",
                                textAlign: pw.TextAlign.center))),
                  ),
                  flex: 2),
              pw.Expanded(
                  child: pw.Container(
                    decoration: pw.BoxDecoration(border: pw.Border.all()),
                    child: pw.Padding(
                        padding: pw.EdgeInsets.all(4),
                        child: pw.SizedBox(
                            child: pw.Text(
                                "${bpReport.minMaxAverageBpReading.maxSystolic}",
                                textAlign: pw.TextAlign.center))),
                  ),
                  flex: 2),
              pw.Expanded(
                  child: pw.Container(
                    decoration: pw.BoxDecoration(border: pw.Border.all()),
                    child: pw.Padding(
                        padding: pw.EdgeInsets.all(4),
                        child: pw.SizedBox(
                            child: pw.Text(
                                "${bpReport.minMaxAverageBpReading.avgSystolic}",
                                textAlign: pw.TextAlign.center))),
                  ),
                  flex: 2),
              pw.Expanded(
                  child: pw.Container(
                    decoration: pw.BoxDecoration(border: pw.Border.all()),
                    child: pw.Padding(
                        padding: pw.EdgeInsets.all(4),
                        child: pw.SizedBox(
                            child: pw.Text(
                                "${StandardBpReading.VeryLowSystolicMaxima} - ${StandardBpReading.MaximumSystolic} ",
                                textAlign: pw.TextAlign.center))),
                  ),
                  flex: 3),
            ]),
          )),
      pw.Container(
          decoration: pw.BoxDecoration(border: pw.Border.all()),
          child: pw.Padding(
            padding: pw.EdgeInsets.all(0),
            child: pw.Row(children: [
              pw.Expanded(
                  child: pw.Container(
                    decoration: pw.BoxDecoration(border: pw.Border.all()),
                    child: pw.Padding(
                        padding: pw.EdgeInsets.all(4),
                        child: pw.SizedBox(child: pw.Text("Diastolic (mmHg)"))),
                  ),
                  flex: 4),
              pw.Expanded(
                  child: pw.Container(
                    decoration: pw.BoxDecoration(border: pw.Border.all()),
                    child: pw.Padding(
                        padding: pw.EdgeInsets.all(4),
                        child: pw.SizedBox(
                            child: pw.Text(
                                "${bpReport.minMaxAverageBpReading.minDiastolic}",
                                textAlign: pw.TextAlign.center))),
                  ),
                  flex: 2),
              pw.Expanded(
                  child: pw.Container(
                    decoration: pw.BoxDecoration(border: pw.Border.all()),
                    child: pw.Padding(
                        padding: pw.EdgeInsets.all(4),
                        child: pw.SizedBox(
                            child: pw.Text(
                                "${bpReport.minMaxAverageBpReading.maxDiastolic}",
                                textAlign: pw.TextAlign.center))),
                  ),
                  flex: 2),
              pw.Expanded(
                  child: pw.Container(
                    decoration: pw.BoxDecoration(border: pw.Border.all()),
                    child: pw.Padding(
                        padding: pw.EdgeInsets.all(4),
                        child: pw.SizedBox(
                            child: pw.Text(
                                "${bpReport.minMaxAverageBpReading.avgDiastolic}",
                                textAlign: pw.TextAlign.center))),
                  ),
                  flex: 2),
              pw.Expanded(
                  child: pw.Container(
                    decoration: pw.BoxDecoration(border: pw.Border.all()),
                    child: pw.Padding(
                        padding: pw.EdgeInsets.all(4),
                        child: pw.SizedBox(
                            child: pw.Text(
                                "${StandardBpReading.VeryHighDiastolicMinima} - ${StandardBpReading.MaximumDiastolic}",
                                textAlign: pw.TextAlign.center))),
                  ),
                  flex: 3),
            ]),
          )),
      pw.Container(
          decoration: pw.BoxDecoration(border: pw.Border.all()),
          child: pw.Padding(
            padding: pw.EdgeInsets.all(0),
            child: pw.Row(children: [
              pw.Expanded(
                  child: pw.Container(
                    decoration: pw.BoxDecoration(border: pw.Border.all()),
                    child: pw.Padding(
                        padding: pw.EdgeInsets.all(4),
                        child: pw.SizedBox(child: pw.Text("Pulse"))),
                  ),
                  flex: 4),
              pw.Expanded(
                  child: pw.Container(
                    decoration: pw.BoxDecoration(border: pw.Border.all()),
                    child: pw.Padding(
                        padding: pw.EdgeInsets.all(4),
                        child: pw.SizedBox(
                            child: pw.Text(
                                "${bpReport.minMaxAverageBpReading.minPulse}",
                                textAlign: pw.TextAlign.center))),
                  ),
                  flex: 2),
              pw.Expanded(
                  child: pw.Container(
                    decoration: pw.BoxDecoration(border: pw.Border.all()),
                    child: pw.Padding(
                        padding: pw.EdgeInsets.all(4),
                        child: pw.SizedBox(
                            child: pw.Text(
                                "${bpReport.minMaxAverageBpReading.maxPulse}",
                                textAlign: pw.TextAlign.center))),
                  ),
                  flex: 2),
              pw.Expanded(
                  child: pw.Container(
                    decoration: pw.BoxDecoration(border: pw.Border.all()),
                    child: pw.Padding(
                        padding: pw.EdgeInsets.all(4),
                        child: pw.SizedBox(
                            child: pw.Text(
                                "${bpReport.minMaxAverageBpReading.avgPulse}",
                                textAlign: pw.TextAlign.center))),
                  ),
                  flex: 2),
              pw.Expanded(
                  child: pw.Container(
                    decoration: pw.BoxDecoration(border: pw.Border.all()),
                    child: pw.Padding(
                        padding: pw.EdgeInsets.all(4),
                        child: pw.SizedBox(
                            child: pw.Text(
                                "${StandardBpReading.MinPulse} - ${StandardBpReading.MaximumPulse}",
                                textAlign: pw.TextAlign.center))),
                  ),
                  flex: 3),
            ]),
          )),
    ]);
  }
}
