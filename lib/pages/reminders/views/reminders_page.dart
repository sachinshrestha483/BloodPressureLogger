import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:mvp1/config/pallete.dart';
import 'package:mvp1/config/typography.dart';
import 'package:mvp1/domain/reminder_repository/reminder_repository.dart';
import 'package:mvp1/domain/reminder_repository/src/models/reminder_model.dart';
import 'package:mvp1/domain/reminder_repository/src/notificationApi.dart';
import 'package:mvp1/domain/user_repository/src/models/models.dart';
import 'package:mvp1/pages/reminders/widgets/add_Reminder_bottom_modalsheet.dart';
import 'package:mvp1/pages/reminders/widgets/individualReminder.dart';
import 'package:mvp1/providers/userProvider.dart';
import 'package:mvp1/widgets/safetext.dart';
import 'package:mvp1/widgets/userspecificappbar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RemindersPage extends StatelessWidget {
  const RemindersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: UserSpecificAppBar("Reminders", context),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Bp Logger',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
              ListTile(
                title: const Text('Export and Send'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                  Navigator.of(context).pushNamed(
                    '/exportandSend',
                  );
                },
              ),
              ListTile(
                title: const Text('Reminders'),
                onTap: () {
                  Navigator.of(context).pushNamed(
                    '/remindersPage',
                  );
                },
              ),
            ],
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Center(
                    child: Text(
                  "Reminders",
                  style: TextStyle(fontSize: 28),
                  textAlign: TextAlign.center,
                )),
                Consumer(builder: (context, watch, child) {
                  final selectedProfileId =
                      watch(selectedProfileProvider).state;

                  return Expanded(
                      child:
                          ListView(scrollDirection: Axis.vertical, children: [
                    ValueListenableBuilder<Box<Reminder>>(
                        valueListenable:
                            ReminderRepository.GetBox().listenable(),
                        builder: (context, box, _) {
                          final reminders = box.values
                              .toList()
                              .cast<Reminder>()
                              .where((element) =>
                                  element.userId == selectedProfileId)
                              .toList();

                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: reminders.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    IndividualReminder(
                                        reminder: reminders[index])
                                  ],
                                );
                              });
                        }),
                  ]));
                }),
                ElevatedButton(
                    onPressed: () {
                      NotificationApi.showNotification(
                          title: "Title is Here",
                          body: "Body of The Notification",
                          payload: 'sarah.abs');
                    },
                    child: Text("ffdfdf"))
              ],
            )),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            AddReminderBottomModalSheet(context);
          },
        ));
  }
}
