import 'package:flutter/material.dart';
import 'LoginPage.dart';
// the first thing imported is the only one that can be rendered

void main() {
  runApp(
    MyApp()
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage()
    );
  }
}
