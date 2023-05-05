import 'package:flutter/material.dart';
import 'package:learning_dart/pages/authenticator.dart';
import 'package:learning_dart/pages/initial_screen.dart';
import 'package:learning_dart/pages/map_page.dart';
import 'package:learning_dart/pages/register_page.dart';

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => InitialScreen(),
        '/second': (context) => Authenticator(),
        '/third': (context) => RegisterPage(),
        '/fourth': (context) => MapPage()
      },
    );
  }
}
