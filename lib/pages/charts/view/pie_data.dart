import 'dart:ui';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mvp1/config/config.dart';

class PieData {
  static List<Data> data = [
    Data('Normal', 40, Pallete.PieChartNormal),
    Data('Stage 1 Hypertension', 30, Pallete.PieChartStage1),
    Data('Stage 2 Hypertension', 15, Pallete.PieChartStage2),
    Data('Stage 3 HyperTension', 15, Pallete.PieChartStage3),
    Data('Hypotension', 15, Pallete.PieChartHypoTension),
  ];
  static List<Data> GetData(
      double normal,
      double stage1Hypertension,
      double stage2Hypertension,
      double stage3Hypertension,
      double hypotension) {
    List<Data> data = [
      Data('Normal', normal, Pallete.PieChartNormal),
      Data('Stage 1 Hypertension', stage1Hypertension, Pallete.PieChartStage1),
      Data('Stage 2 Hypertension', stage2Hypertension, Pallete.PieChartStage2),
      Data('Stage 3 HyperTension', stage3Hypertension, Pallete.PieChartStage3),
      Data('Hypotension', hypotension, Pallete.PieChartHypoTension),
    ];

    return data;
  }
}

class Data {
  late final String name;

  late final double percent;

  late final Color color;

  Data(this.name, this.percent, this.color);
}

List<PieChartSectionData> GetPieChartSections(List<Data> data) {
  var sectionsData = data
      .asMap()
      .map<int, PieChartSectionData>((index, data) {
        final value = PieChartSectionData(
          color: data.color,
          value: data.percent,
          title: '${data.percent}%',
          titleStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff),
          ),
        );

        return MapEntry(index, value);
      })
      .values
      .toList();

  return sectionsData;
}

List<PieChartSectionData> getSections() => PieData.data
    .asMap()
    .map<int, PieChartSectionData>((index, data) {
      final value = PieChartSectionData(
        color: data.color,
        value: data.percent,
        title: '${data.percent}%',
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
        ),
      );

      return MapEntry(index, value);
    })
    .values
    .toList();
