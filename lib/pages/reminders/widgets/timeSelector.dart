import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

typedef void  SetTimeCallback(TimeOfDay time);
class TimeSelector extends StatefulWidget {
  final  SetTimeCallback setTimeCallback;

   TimeSelector({Key? key,required this.setTimeCallback}) 
   : super(key: key);
  @override
  _TimeSelectorState createState() => _TimeSelectorState( setTimeCallback);
}

class _TimeSelectorState extends State<TimeSelector> {
  TimeOfDay? time;

 late SetTimeCallback onTimeChange;

_TimeSelectorState(SetTimeCallback setTimeCallback){
onTimeChange= setTimeCallback;
}






  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            pickTime(context);
          },
          child: Text(getText()),
        ));
  }

  String getText() {
    if (time == null) {
      return "Select  Time";
    } else {
      return " ${time?.format(context) } ";
    }
  }

  Future pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime =
        await showTimePicker(context: context, initialTime: initialTime);

    if (newTime == null) {
      return null;
    }

    setState(() {
      time = newTime;
      onTimeChange(time!);
    });
  }
}
