import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:mvp1/Utility/Uid.dart';
import 'package:mvp1/domain/user_repository/src/enums/gender.dart';
import 'package:mvp1/providers/Boxes.dart';
import 'package:mvp1/providers/userProvider.dart';
import 'models/user_model.dart';

class UserRepository {
  static Box<User> GetBox() {
    return Hive.box<User>(Boxes.UserBox);
  }

  static List<User> getUsers() {
    var userBox = Hive.box<User>(Boxes.UserBox);
    var users = userBox.values.toList();
    return users;
  }

  static void addUser(User user) {
    var userBox = Hive.box<User>(Boxes.UserBox);
    userBox.put(GetUID(), user);

    user.save();
  }

  static String GetGenderDisplayString(Gender gender) {
    switch (gender) {
      case Gender.male:
        return "Male";

      case Gender.female:
        return "Female";

      case Gender.others:
        return "Others";
    }
  }

  static setSelectedProfile(String id, BuildContext context) {
    var configBox = Hive.box<String>(Boxes.ConfigBox);
    setSelectedProfleProvider(id, context);
    configBox.put(Keys.SelectedUser, id);
  }

// returns the key
  static String? getSelectedProfile() {
    var configBox = Hive.box<String>(Boxes.ConfigBox);
    var selectedProfile = configBox.get(Keys.SelectedUser);
    return selectedProfile;
  }

  static User GetUser(String? id) {
    if (id == null) {
      var user = new User();
      user.name = "";
      user.age = 1;
      user.gender = Gender.male.index;
      return user;
    }
    var userBox = Hive.box<User>(Boxes.UserBox);
    var userd = userBox.get(id);
    if (userd == null) {
      var user = new User();
      user.name = "";
      user.age = 1;
      user.gender = Gender.male.index;
      return user;
    }

    return userd;
  }
}
