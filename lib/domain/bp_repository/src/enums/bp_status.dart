enum BpStatus { Normal, High, Low, Very_High, Very_Low, HighPulse,LowPulse, Normal_Pulse }
extension BpStatusExtension on BpStatus {

  String get GetDisplayString {
    switch (this) {
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

}