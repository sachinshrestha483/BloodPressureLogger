import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:mvp1/config/config.dart';
import 'package:mvp1/domain/user_repository/src/enums/gender.dart';
import 'package:mvp1/domain/user_repository/user_repository.dart';
import 'package:mvp1/widgets/widgets.dart';

class AddUserForm extends StatefulWidget {
  const AddUserForm({Key? key, required this.user}) : super(key: key);
  final User user;
  @override
  _AddUserFormState createState() => _AddUserFormState(user);
}

class _AddUserFormState extends State<AddUserForm> {
  late Gender gender;
  late String name;
  late int age;
  _AddUserFormState(User user) {
    name = user.name;
    age = user.age;
    gender = Gender.values[user.gender];
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void submit() {
      bool? isValid = _formKey.currentState?.validate();
      if (isValid == true) {
        _formKey.currentState?.save(); // Save our form now.
        var user = new User();
        user.name = name;
        user.age = age;
        user.gender = gender.index;
        print("User Name: ${name.toString()}");
        print("User age :${age.toString()}");
        print("User Gender:  ${gender.toString()}");
        UserRepository.addUser(user);
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
                maxLength: 30,
                onSaved: (value) => setState(() => name = value.toString()),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder(),
                ),
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ], // Only numbers can be entered
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Age Cant be null';
                  }
                  if (int.parse(value) < 0) {
                    return 'Age Cant Be Less Than 0';
                  } else {
                    return null;
                  }
                },
                maxLength: 30,
                onSaved: (value) {
                  age = int.parse(value!);
                },
              ),
              DropdownButton<Gender>(
                  value: gender,
                  onChanged: (newValue) {
                    setState(() {
                      print("Changing The Gender Value");
                      print(newValue!.index.toString());
                      gender = newValue;
                      print("Gender ${gender}");
                      //gender = newValue!.index;
                    });
                    gender = newValue!;
                  },
                  items: Gender.values.map((Gender gender) {
                    return DropdownMenuItem<Gender>(
                        value: gender,
                        child: Text(
                            UserRepository.GetGenderDisplayString(gender)));
                  }).toList()),
              BuildPrimaryButton(
                  submit,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add),
                      BuildSafeText(
                          "Add Profile", AppTypography.PrimaryTextStyle)
                    ],
                  )),
            ],
          )),
    );
  }
}
