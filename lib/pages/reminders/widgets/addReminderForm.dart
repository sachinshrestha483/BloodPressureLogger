import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/src/provider.dart';
import 'package:mvp1/config/config.dart';
import 'package:mvp1/domain/reminder_repository/reminder_repository.dart';
import 'package:mvp1/domain/reminder_repository/src/models/reminder_model.dart';
import 'package:mvp1/domain/user_repository/src/enums/gender.dart';
import 'package:mvp1/domain/user_repository/user_repository.dart';
import 'package:mvp1/pages/reminders/widgets/timeSelector.dart';
import 'package:mvp1/providers/userProvider.dart';
import 'package:mvp1/widgets/widgets.dart';

import 'weekday_selector.dart';

class AddReminderForm extends StatefulWidget {
  const AddReminderForm({Key? key}) : super(key: key);

  @override
  _AddReminderFormState createState() => _AddReminderFormState();
}

class _AddReminderFormState extends State<AddReminderForm> {
  late TimeOfDay? timeOfDay;
  late Gender gender;
  late String name;
  late int age;
  late bool sunday=true;
  late bool monday= true;
  late bool tuesday= true;
  late bool wednesday= true;
  late bool thursday= true;
  late bool friday=true;
  late bool saturday=true;
  // TimeOfDay? time = null;

  void setTime(TimeOfDay selectedTime) {
    setState(() {
      timeOfDay = selectedTime;
    });
  }

  void setWeekDays(bool isSunday, bool isMonday, bool isTuesday,
      bool isWednesday, bool isThursday, bool isFriday, bool isSaturday) {
    setState(() {
      sunday = isSunday;
      monday = isMonday;
      tuesday = isTuesday;
      wednesday = isWednesday;
      thursday = isThursday;
      friday = isFriday;
      saturday = isSaturday;
      sunday = isSunday;
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void submit() {
      bool? isValid = _formKey.currentState?.validate();
      if (isValid == true) {
        _formKey.currentState?.save(); // Save our form now.
       if(timeOfDay==null){
return;
       }

  var   userId = context.read(selectedProfileProvider).state.toString();

var reminder= new Reminder();
reminder.name= name;
reminder.note="";
reminder.monday=monday;
reminder.tuesday=tuesday;
reminder.wednesday=wednesday;
reminder.thursday=thursday;
reminder.friday= friday;
reminder.saturday=saturday;
reminder.sunday=sunday;
reminder.time= DateTime.now();
reminder.userId=userId;
reminder.isactive=true;
print("Adding The Reminder");
ReminderRepository.add(reminder);
_formKey.currentState?.reset();
      }
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.length < 4 || value.isEmpty) {
                    return 'Enter at least 4 characters';
                  } else {
                    return null;
                  }
                },
                maxLength: 50,
                onSaved: (value) => setState(() => name = value.toString()),
              ),
              TimeSelector(
                setTimeCallback: setTime,
              ),
              WeekDaySelector(weekDaySelectorCallBack: setWeekDays,),
              BuildPrimaryButton(
                  submit,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add),
                      BuildSafeText(
                          "Add Reminder", AppTypography.PrimaryTextStyle)
                    ],
                  )),
            ],
          )),
    );
  }
}
