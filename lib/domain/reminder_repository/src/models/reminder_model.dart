import 'package:hive/hive.dart';
part 'reminder_model.g.dart';

@HiveType(typeId: 2)
class Reminder extends HiveObject {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late DateTime time;
  @HiveField(2)
  late bool gender;
  @HiveField(3)
  late bool monday;
  @HiveField(4)
  late bool tuesday;
  @HiveField(5)
  late bool wednesday;
  @HiveField(6)
  late bool thursday;
  @HiveField(7)
  late bool friday;
  @HiveField(8)
  late bool saturday;
  @HiveField(9)
  late bool sunday;
    @HiveField(10)
  late int userId;
   @HiveField(11)
  late String note; 
}
