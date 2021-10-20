import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mvp1/config/config.dart';
import 'package:mvp1/config/modal_bottomsheetStyle.dart';
import 'package:mvp1/domain/user_repository/user_repository.dart';
import 'package:mvp1/widgets/widgets.dart';

import 'UserButton.dart';
import 'addUserBottomModalSheet.dart';

Future<void> BuildUsersBottomModalSheet(BuildContext context) {
  return showModalBottomSheet<void>(
      shape: ModalBottomSheetStyle.modalBottomSheetShape,
      backgroundColor: Pallete.ModalBottomSheetBgColor,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            height: 200,
            child: Column(
              children: [
                ElevatedButton(
                    onPressed: () {
                      print("Button Pressed");
                      BuildAddUserBottomModalSheet(context);
                      // showModalBottomSheet(
                      //     context: context,
                      //     builder: (context) {
                      //       return BuildForm(AddUserForm(
                      //           user: UserRepository.GetUser(null)));
                      //     });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                          ),
                          BuildSafeText(
                              "Add New Profile", AppTypography.PrimaryTextStyle)
                        ],
                      ),
                    )),
                SizedBox(
                  height: 10,
                ),
                Flexible(
                  child: ValueListenableBuilder<Box<User>>(
                      valueListenable: UserRepository.GetBox().listenable(),
                      builder: (context, box, _) {
                        final users = box.values.toList().cast<User>();
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: UserRepository.GetBox().length,
                          itemBuilder: (context, index) {
                            return BuildUserButton(
                                () => {
                                      UserRepository.setSelectedProfile(
                                          UserRepository.getUsers()
                                              .elementAt(index)
                                              .key,
                                          context),
                                      // Navigator.of(context).pushNamed(
                                      //   '/readingsPage',
                                      // )
                                    },
                                UserRepository.getUsers()[index].name);
                          },
                        );
                      }),
                ),
              ],
            ),
          ),
        );
      });
}
