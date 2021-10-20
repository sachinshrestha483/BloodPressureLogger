import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mvp1/config/config.dart';
import 'package:mvp1/domain/authentication/authentication.dart';
import 'package:mvp1/domain/bp_repository/src/bp_repository.dart';
import 'package:mvp1/domain/bp_repository/src/models/models.dart';
import 'package:mvp1/providers/userProvider.dart';
import 'package:mvp1/widgets/userspecificappbar.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:mvp1/widgets/widgets.dart';

class NewReadingPage extends StatefulWidget {
  final Bp bp;
  NewReadingPage({Key? key, required this.bp}) : super(key: key);

  @override
  State<NewReadingPage> createState() => _NewReadingPageState();
}

class _NewReadingPageState extends State<NewReadingPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late int systolic = widget.bp.systolic;

  late int diastolic = widget.bp.diastolic;

  late int pulse = widget.bp.pulse;

  late String note = widget.bp.note;

  late String userId;

  late DateTime readingDateTime = widget.bp.readingDateTime;

  @override
  Widget build(BuildContext context) {
    void submit() {
      bool? isValid = _formKey.currentState?.validate();
      if (isValid == true) {
        _formKey.currentState?.save(); // Save our form now.

        print("Systolic:" + systolic.toString());
        print("Diastolic:" + diastolic.toString());
        print("Pulse:" + pulse.toString());
        print("Reading Time:" + readingDateTime.toString());
        userId = context.read(selectedProfileProvider).state.toString();
        print("UserId:" + userId);

        // widget.bp.systolic = systolic;
        // widget.bp.diastolic = diastolic;
        // widget.bp.pulse = pulse;
        // widget.bp.note = note;
        // widget.bp.readingDateTime = readingDateTime;
        // widget.bp.takenOn = DateTime.now();
        // widget.bp.userId = userId;

        var bp = new Bp();
        bp.systolic = systolic;
        bp.diastolic = diastolic;
        bp.pulse = pulse;
        bp.note = note;
        bp.readingDateTime = readingDateTime;
        bp.takenOn = DateTime.now();
        bp.userId = userId;

        BpRepository.add(bp);

        _formKey.currentState?.reset();
      }
    }

    return Scaffold(
      appBar: UserSpecificAppBar("New Reading", context),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      child: DateTimeField(
                    decoration: InputDecoration(
                      labelText: 'Date and Time Of Reading',
                      border: OutlineInputBorder(),
                    ),
                    format: Config.DateTimeformat,
                    onShowPicker: (context, readingDateTime) async {
                      final date = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: readingDateTime ?? DateTime.now(),
                          lastDate: DateTime(2100));
                      if (date != null) {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(
                              readingDateTime ?? DateTime.now()),
                        );
                        return DateTimeField.combine(date, time);
                      } else {
                        return readingDateTime;
                      }
                    },
                    onSaved: (selectedDate) {
                      readingDateTime = selectedDate ?? DateTime.now();
                    },
                  )),
                  SizedBox(
                    height: 18,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Systolic',
                              border: OutlineInputBorder(),
                            ),
                            initialValue: systolic.toString()=="0"?null:systolic.toString(),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ], // Only numbers can be entered
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              return validateSystolic(value);
                            },
                            maxLength: 3,
                            onSaved: (value) {
                              systolic = int.parse(value!);
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: TextFormField(
                            initialValue: diastolic.toString()=="0"?null:diastolic.toString(),
                            decoration: InputDecoration(
                              labelText: 'diastolic',
                              border: OutlineInputBorder(),
                            ),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ], // Only numbers can be entered
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              return validateDiastolic(value);
                            },
                            maxLength: 3,
                            onSaved: (value) {
                              diastolic = int.parse(value!);
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: TextFormField(
                            initialValue: pulse.toString()=="0"?null:pulse.toString(),
                            decoration: InputDecoration(
                              labelText: 'pulse',
                              border: OutlineInputBorder(),
                            ),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ], // Only numbers can be entered
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              return validatePulse(value);
                            },
                            maxLength: 3,
                            onSaved: (value) {
                              pulse = int.parse(value!);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  TextFormField(
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: 'Note',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      validateNote(value);
                    },
                    maxLength: 1000,
                    onSaved: (value) {
                      if (value == null) {
                        note = "";
                      } else {
                        note = value;
                      }
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  BuildPrimaryButton(
                      submit,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add),
                          BuildSafeText(
                              "Add Reading", AppTypography.PrimaryTextStyle)
                        ],
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
