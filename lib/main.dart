import 'package:flutter/material.dart';
import 'package:mvvm_authorisation/ui_screens/auth_screen/auth_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp.create());
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
      home: AuthScreen.create(),
    );
  }

  static Widget create() {
    return Provider(
      create: (_) => _ViewModel(),
      lazy: false,
      child: const MyApp(),
    );
  }
}

class _ViewModel {}
