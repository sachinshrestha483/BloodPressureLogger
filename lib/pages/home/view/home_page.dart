import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mvp1/config/config.dart';
import 'package:mvp1/config/modal_bottomsheetStyle.dart';

import 'package:mvp1/config/pallete.dart';
import 'package:mvp1/config/typography.dart';
import 'package:mvp1/domain/user_repository/src/user_repository.dart';
import 'package:mvp1/domain/user_repository/user_repository.dart';
import 'package:mvp1/pages/home/widgets/AddUserForm.dart';
import 'package:mvp1/pages/home/widgets/UserButton.dart';
import 'package:mvp1/pages/home/widgets/buildForm.dart';
import 'package:mvp1/widgets/safetext.dart';
import "package:mvp1/widgets/widgets.dart";
import 'package:hexcolor/hexcolor.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Appbar("BP Logger App"),
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Center(
            child: Row(
              children: [
                Expanded(
                  flex: 1, // takes 30% of available width
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: ValueListenableBuilder<Box<User>>(
                            valueListenable:
                                UserRepository.GetBox().listenable(),
                            builder: (context, box, _) {
                              final users = box.values.toList().cast<User>();
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: UserRepository.GetBox().length,
                                itemBuilder: (context, index) {
                                  return BuildUserButton(
                                      () => {
                                        UserRepository.setSelectedProfile( UserRepository.getUsers().elementAt(index).key,context),
                                            Navigator.of(context).pushNamed(
                                              '/readingsPage',
                                            )
                                          },
                                      UserRepository.getUsers()[index].name);
                                },
                              );
                            }),
                      ),
                      SizedBox(height: 16,),
                      ElevatedButton(
                          onPressed: () {
                            print("Button Pressed");

                            showModalBottomSheet(
                              shape: ModalBottomSheetStyle.modalBottomSheetShape,
                              backgroundColor: Pallete.ModalBottomSheetBgColor,
                                context: context,
                                builder: (context) {
                                  return BuildForm(AddUserForm(
                                      user: UserRepository.GetUser(null)));
                                });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                ),
                                BuildSafeText("Add New Profile",
                                    AppTypography.PrimaryTextStyle)
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1, // takes 30% of available width
                  child: SizedBox(),
                ),
              ],
            ),
          ),
        ));
  }
}
