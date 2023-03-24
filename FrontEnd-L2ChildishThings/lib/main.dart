import 'package:flutter/material.dart';
import 'package:myproject/stripes.dart';
import 'package:myproject/selection.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PhotoBoothMe',
      home:AdminForm(),
      debugShowCheckedModeBanner: false,
    );
  }
}
