

// ignore_for_file: unused_import, use_key_in_widget_constructors, prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:frontend/forgotpassword.dart';
import 'package:frontend/loginscreen.dart';
import 'package:frontend/otp_screen.dart';
import 'package:frontend/send_otp.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_state.dart';
import 'homepage.dart';



void main()  {

  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState().loginState,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      title: 'Flutter UI',
      theme: ThemeData(
        hoverColor: Colors.deepOrange,
        primarySwatch: Colors.deepOrange,
        snackBarTheme: const SnackBarThemeData(
        backgroundColor: Colors.deepOrange,
        contentTextStyle: TextStyle(
        fontSize: 20,
    ),
      ),
      ),
      home: HomePage(),    //loginscreen()
      debugShowCheckedModeBanner: false,
    );
  }
}

