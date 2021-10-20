import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mvp1/domain/bp_repository/src/models/bp_model.dart';
import 'package:mvp1/domain/reminder_repository/src/models/reminder_model.dart';
import 'package:mvp1/pages/readings/readings.dart';
import 'package:mvp1/providers/Boxes.dart';
import 'package:mvp1/providers/userProvider.dart';
import 'package:mvp1/route_generator.dart';
import 'domain/user_repository/user_repository.dart';
import 'domain/bp_repository/bp_repository.dart';
import 'domain/reminder_repository/reminder_repository.dart';
import 'pages/home/home.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid_type/uuid_type.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(BpAdapter());
  Hive.registerAdapter(ReminderAdapter());
  await Hive.openBox<User>('users');
  await Hive.openBox<Reminder>('reminders');
  await Hive.openBox<Bp>('bpreadings');
  await Hive.openBox<String>(Boxes.ConfigBox);

  runApp(ProviderScope(
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      home: autoRoute(),
    );
  }
}

Widget autoRoute() {

  if (UserRepository.getSelectedProfile() != null) {
   // return HomePage();

     return ReadingsPage();
  } else {
    return HomePage();
  }
}


// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Text("Sacc")
     
//     );
//   }
// }
