import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:mvp1/Utility/Uid.dart';
import 'package:mvp1/config/config.dart';
import 'package:mvp1/domain/bp_repository/src/StandardBpUnits.dart';
import 'package:mvp1/domain/bp_repository/src/models/bp_info.dart';
import 'package:mvp1/providers/Boxes.dart';

import 'enums/bp_status.dart';
import 'models/bp_model.dart';

class BpRepository {
  static Box<Bp> GetBox() {
    return Hive.box<Bp>(Boxes.BpreadingsBox);
  }

  static void add(Bp bp) {
    var bpBox = Hive.box<Bp>(Boxes.BpreadingsBox);
    bpBox.put(GetUID(), bp);
    bp.save();
  }

  static void Remove(String key) {
    var bpBox = Hive.box<Bp>(Boxes.BpreadingsBox);
    bpBox.delete(key);
  }


static String GetBpStatusDisplayString(BpStatus bpStatus){
    switch (bpStatus) {
      case BpStatus.LowPulse:
        return 'Low';
      case BpStatus.Normal_Pulse:
        return 'Normal';
      case BpStatus.HighPulse:
        return 'High';
         case BpStatus.Very_Low:
        return 'Very Low';
         case BpStatus.Low:
        return 'Low'; 
        case BpStatus.High:
        return 'High';
        case BpStatus.Very_High:
        return 'Very High';
        case BpStatus.Normal:
        return 'Normal';
     
      default:
        return "";
    }
}



static Color GetBpStatusColor(BpStatus bpStatus){
    switch (bpStatus) {
      case BpStatus.LowPulse:
        return  Pallete.LightRed;

      case BpStatus.Normal_Pulse:
        return Pallete.LightGreen;

      case BpStatus.HighPulse:
        return Pallete.DarkRed;

      case BpStatus.Very_Low:
        return Pallete.DarkRed;
         
      case BpStatus.Low:
        return Pallete.LightRed; 
      
      case BpStatus.High:
        return  Pallete.LightRed;
      
      case BpStatus.Very_High:
        return Pallete.DarkRed;
      
      case BpStatus.Normal:
        return Pallete.LightGreen;
     
      default:
        return Pallete.LightGreen;
    }
}




  static Bp Get(String? id) {
    if (id == null) {
      var bp = new Bp();
      bp.systolic = 0;
      bp.diastolic = 0;
      bp.pulse = 0;
      bp.readingDateTime = DateTime.now();

      return bp;
    }
    var bp = new Bp();
    bp.systolic = 0;
    bp.diastolic = 0;
    bp.pulse = 0;
    bp.readingDateTime = DateTime.now();
    bp.note = "dsds";
    return bp;
  }

  static BpStatus GetPulseStatus(Bp bp) {
    if (_isHighPulse(bp)) {
      return BpStatus.HighPulse;
    }
    else if(_isLowPulse(bp)){
      return BpStatus.LowPulse;

    }
     else {
      return BpStatus.Normal_Pulse;
    }
  }

  static BpStatus GetBpStatus(Bp bp) {
    if (_isHighBp(bp)) {
      if (_isVeryHighBp(bp)) {
        return BpStatus.Very_High;
      }
      return BpStatus.High;
    } else if (_isLowBp(bp)) {
      if (_isVeryLowBp(bp)) {
        return BpStatus.Very_Low;
      }
      return BpStatus.Low;
    } else {
      return BpStatus.Normal;
    }
  }



  static bool _isHighBp(Bp bp) {
    var isHigh = bp.systolic > StandardBpReading.MaximumSystolic ||
        bp.diastolic > StandardBpReading.MaximumDiastolic ||
        bp.pulse > StandardBpReading.MaximumPulse;
    return isHigh;
  }

  static bool _isLowBp(Bp bp) {
    var isLow = bp.systolic < StandardBpReading.MinimumSystolic ||
        bp.diastolic < StandardBpReading.MinimumDiastolic ||
        bp.pulse < StandardBpReading.MinimumPulse;
    return isLow;
  }

  static bool _isVeryHighBp(Bp bp) {
    var isVeryLow = bp.systolic >= StandardBpReading.VeryHighSystolicMinima ||
        bp.diastolic >= StandardBpReading.VeryHighDiastolicMinima;
    return isVeryLow;
  }

  static bool _isVeryLowBp(Bp bp) {
    var isVeryHigh = bp.systolic <= StandardBpReading.VeryLowSystolicMaxima ||
        bp.diastolic <= StandardBpReading.VeryLowDiastolicMaxima;
    return isVeryHigh;
  }

  static bool _isHighPulse(Bp bp) {
    var isHighPulse = bp.pulse > StandardBpReading.MaxPulse;
    return isHighPulse;
  }

  static bool _isLowPulse(Bp bp) {
    var isLowPulse = bp.pulse < StandardBpReading.MinPulse;
    return isLowPulse;
  }




  static String _getPulseInfoMessage(BpStatus bpStatus) {
    String message = "Normal";
    if (bpStatus == BpStatus.HighPulse) {
      message = "High Pulse";
    }
    if (bpStatus == BpStatus.LowPulse) {
      message = "Low Pulse";
    }
    return message;
  }

  static String _getBpInfoMessage(BpStatus bpStatus) {
    String message = "";

    if (bpStatus == BpStatus.High) {
      message = "High Blood Pressure";
    }
    if (bpStatus == BpStatus.Low) {
      message = "Low Blood Pressure";
    }
    if (bpStatus == BpStatus.Very_High) {
      message = "Very High Blood Pressure";
    }
    if (bpStatus == BpStatus.Very_Low) {
      message = "Very Low Blood Pressure";
    }
    if (bpStatus == BpStatus.Normal) {
      message = "Normal";
    }

    return message;
  }

  static String _GetPulseSummary(BpStatus bpStatus) {
    String summary = "";

    if (bpStatus == BpStatus.HighPulse) {
      summary = "Your Pulse is High";
    } else if (bpStatus == BpStatus.LowPulse) {
      summary = "Your Pulse is Low ";
    } else {
      summary = "Your Pulse is Normal";
    }
    return summary;
  }

  static String _getBpInfoSummary(BpStatus bpStatus) {
    String summary = "";
    if (bpStatus == BpStatus.Very_High) {
      summary = "Your Blood Pressure is Very High ";
    } else if (bpStatus == BpStatus.Very_Low) {
      summary = "Your Blood Pressure is Very Low";
    } else if (bpStatus == BpStatus.High) {
      summary = "Your Blood Pressure is High";
    } else if (bpStatus == BpStatus.Low) {
      summary = "Your  Blood Pressure is Low";
    }

    if (bpStatus == BpStatus.Normal) {
      summary = "Your Bp is Normal";
    }

    return summary;
  }

  static BpInfo GetBpInfo(Bp bp) {
    var bpInfo = new BpInfo();
    var bpStatus = GetBpStatus(bp);
    var pulseStatus = GetPulseStatus(bp);

    var bpMessage = _getBpInfoMessage(bpStatus);
    var pulseMessage = _getPulseInfoMessage(bpStatus);

    bpInfo.message.add(bpMessage);
    bpInfo.message.add(pulseMessage);
    bpInfo.summary =
        _getBpInfoSummary(bpStatus) + " and " + _GetPulseSummary(pulseStatus);

    return bpInfo;
  }
}
