import 'package:mvp1/domain/bp_repository/src/enums/bp_status.dart';
import 'package:mvp1/domain/bp_repository/src/models/models.dart';

class BpInfo {
  late List<String> message;
  late BpStatus bpStatus;
  late String summary;
  BpInfo(){
    message=<String>[];
  }



}
