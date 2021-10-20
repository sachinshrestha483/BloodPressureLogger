import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvp1/domain/user_repository/src/user_repository.dart';

// class UserProvider {
//   static Box<User> getTransactions() =>
//       Hive.box<User>('transactions');
// }
final selectedProfileProvider = StateProvider<String?>((ref) => UserRepository.getSelectedProfile());

void setSelectedProfleProvider(String? id,BuildContext context) {
 context.read(selectedProfileProvider).state=id;
}
