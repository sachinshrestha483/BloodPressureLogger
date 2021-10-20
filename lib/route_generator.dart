import 'package:flutter/material.dart';
import 'package:mvp1/pages/allreadings/allreadings.dart';
import 'package:mvp1/pages/home/home.dart';
import 'package:mvp1/pages/readings/readings.dart';

import 'domain/bp_repository/src/models/models.dart';
import 'main.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/readingsPage':
        // Validation of correct data type
        return MaterialPageRoute(builder: (_) => ReadingsPage());
      // If args is not of the correct type, return an error page.
      // You can also throw an exception while in development.

      case '/newReadingPage':
        if (args is Bp) {
          return MaterialPageRoute(
              builder: (_) => NewReadingPage(
                    bp: args,
                  ));
        }
        return _errorRoute();

        case '/allReadingPage':
          return MaterialPageRoute(
              builder: (_) => AllReadingsPage(
                  ));
        



      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Some Error Occured We Are Sorry For That'),
        ),
      );
    });
  }
}
