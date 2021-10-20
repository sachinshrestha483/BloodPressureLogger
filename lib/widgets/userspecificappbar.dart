import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mvp1/config/config.dart';
import 'package:mvp1/domain/user_repository/src/user_repository.dart';
import 'package:mvp1/domain/user_repository/user_repository.dart';
import 'package:mvp1/pages/home/widgets/AddUserForm.dart';
import 'package:mvp1/pages/home/widgets/UserButton.dart';
import 'package:mvp1/pages/home/widgets/addUserBottomModalSheet.dart';
import 'package:mvp1/pages/home/widgets/buildForm.dart';
import 'package:mvp1/pages/home/widgets/usersBottomModalSheet.dart';
import 'package:mvp1/providers/userProvider.dart';
import 'package:mvp1/widgets/widgets.dart';

AppBar UserSpecificAppBar(
  String title,
  BuildContext context
) {
  return AppBar(
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Consumer(
            builder: (context, watch, child) {
              final selectedProfile = watch(selectedProfileProvider).state;
              return Text(  UserRepository.GetUser(selectedProfile).name.toString(), style: TextStyle(fontSize: 17),);
            },
           )
      ],
    ),
    actions: [
      GestureDetector(
        onTap: (){
          BuildUsersBottomModalSheet(context);
          // showModalBottomSheet<void>(
          //   context:context,
          //   builder: (BuildContext context) {
          //  return Container(
          //    height: 200,
          //    color: Colors.grey[400],
          //    child: Column(
          //      children: [

          //          ElevatedButton(
          //                 onPressed: () {
          //                   print("Button Pressed");
          //                BuildAddUserBottomModalSheet(context);
          //                   // showModalBottomSheet(
          //                   //     context: context,
          //                   //     builder: (context) {
          //                   //       return BuildForm(AddUserForm(
          //                   //           user: UserRepository.GetUser(null)));
          //                   //     });
          //                 },
          //                 child: Padding(
          //                   padding: const EdgeInsets.all(16.0),
          //                   child: Row(
          //                     mainAxisAlignment: MainAxisAlignment.center,
          //                     children: [
          //                       Icon(
          //                         Icons.add,
          //                       ),
          //                       BuildSafeText("Add New Profile",
          //                           AppTypography.PrimaryTextStyle)
          //                     ],
          //                   ),
          //                 )
          //                 ),
          //    Flexible(
          //               child: ValueListenableBuilder<Box<User>>(
          //                   valueListenable:
          //                       UserRepository.GetBox().listenable(),
          //                   builder: (context, box, _) {
          //                     final users = box.values.toList().cast<User>();
          //                     return ListView.builder(
          //                       shrinkWrap: true,
          //                       itemCount: UserRepository.GetBox().length,
          //                       itemBuilder: (context, index) {
          //                         return BuildUserButton(
          //                             () => {
          //                               UserRepository.setSelectedProfile( UserRepository.getUsers().elementAt(index).key,context),
          //                                   // Navigator.of(context).pushNamed(
          //                                   //   '/readingsPage',
          //                                   // )
          //                                 },
          //                             UserRepository.getUsers()[index].name);
          //                       },
          //                     );
          //                   }),
          //             ),     
          //      ],
          //    ),
          //  );
          //   });
        },
        child: CircleAvatar(radius: 20,backgroundColor: Colors.purple[700],
        child:Icon(
          Icons.person,
          color: Colors.white70,
      
        ) ,),
      )
    ],
  );
}
