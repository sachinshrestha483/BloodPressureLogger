import 'package:flutter/material.dart';
import 'package:mvp1/domain/bp_repository/src/enums/bp_category.dart';
import 'package:mvp1/domain/bp_repository/src/enums/bp_status.dart';

class BpCategoryEnumHelper {
  String GetDisplayString(BpCategory bpStatus) {
    switch (bpStatus) {
      case BpCategory.Hypotension:
        return "Hypotension";

      case BpCategory.Normal:
        return "Normal";

      case BpCategory.Stage1HyperTension:
        return "Stage 1 Hypertension";
      case BpCategory.Stage2HyperTension:
        return "Stage 2 Hypertension";
      case BpCategory.Stage3HyperTension:
        return "Stage 3 Hypertension";
    }
  }
}
