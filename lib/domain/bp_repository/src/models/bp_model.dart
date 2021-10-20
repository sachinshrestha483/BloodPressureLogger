import 'package:hive/hive.dart';
part 'bp_model.g.dart';

@HiveType(typeId: 1)
class Bp extends HiveObject {
  @HiveField(6)
  late int systolic;
  @HiveField(1)
  late int diastolic;
  @HiveField(2)
  late int pulse;
  @HiveField(3)
  late String note;
  @HiveField(5)
  late String userId;
  @HiveField(9)
  late DateTime readingDateTime;
  @HiveField(8)
  late DateTime takenOn;

}
