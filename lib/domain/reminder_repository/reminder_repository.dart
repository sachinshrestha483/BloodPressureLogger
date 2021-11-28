import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:mvp1/Utility/Uid.dart';
import 'package:mvp1/domain/user_repository/src/enums/gender.dart';
import 'package:mvp1/providers/Boxes.dart';

import 'src/models/reminder_model.dart';

class ReminderRepository {
  
  static Box<Reminder> GetBox(){
    return Hive.box<Reminder>(Boxes.RemindersBox);
  }

  static List<Reminder> getReminders(){
        var reminderBox = Hive.box<Reminder>(Boxes.RemindersBox);
    var reminders = reminderBox.values.toList();
    return reminders;
  }
  
   static void add(Reminder reminder){
    var reminderBox = Hive.box<Reminder>(Boxes.RemindersBox);
    reminderBox.put(GetUID(), reminder);
    reminder.save();
  }

}




  
