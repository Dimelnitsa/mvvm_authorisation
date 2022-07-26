import 'package:flutter/material.dart';
import 'package:mvvm_authorisation/ui_screens/auth_screen/auth_screen.dart';
import 'package:mvvm_authorisation/ui_screens/loader_widget.dart';
import 'package:mvvm_authorisation/ui_screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
       // 'auth': (_) => AuthScreen.create(),
        //'main': (_) => MainScreen.create(),
        'loader': (_) => LoaderWidget.create(),
      },
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name == 'auth') {
          return PageRouteBuilder<dynamic>(
              pageBuilder: (context, animation1, animation2) =>
                  AuthScreen.create(),
              transitionDuration: Duration.zero);
        } else if (settings.name == 'main') {
          return PageRouteBuilder<dynamic>(
              pageBuilder: (context, animation1, animation2) =>
                  MainScreen.create(),
              transitionDuration: Duration.zero);
        }
      },
      home: LoaderWidget.create(),
    );
  }
}
