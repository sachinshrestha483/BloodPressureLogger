import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvp1/config/config.dart';
import 'package:mvp1/config/modal_bottomsheetStyle.dart';
import 'package:mvp1/domain/user_repository/user_repository.dart';

import 'AddUserForm.dart';
import 'buildForm.dart';

Future<void> BuildAddUserBottomModalSheet(BuildContext context) {
  return showModalBottomSheet(
    shape: ModalBottomSheetStyle.modalBottomSheetShape,
    backgroundColor: Pallete.ModalBottomSheetBgColor,
      context: context,
      builder: (context) {
        return BuildForm(AddUserForm(user: UserRepository.GetUser(null)));
      });
}
