
import 'package:device_preview/device_preview.dart';
import "package:flutter/material.dart";
import 'package:frontend/donation_form.dart';
import 'package:frontend/item_page.dart';
import "credi_card_page.dart";
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:form_validator/form_validator.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'homepage.dart';



// ignore_for_file: unused_import, use_key_in_widget_constructors, prefer_const_constructors, duplicate_ignore



import 'package:frontend/forgotpassword.dart';
import 'package:frontend/loginscreen.dart';
import 'package:frontend/otp_screen.dart';
import 'package:frontend/send_otp.dart';




void main(){
  runApp(
      DevicePreview(
        enabled: true,
        builder: (context) => MyApp(),
      ));
}
class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var supportedLocales;
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        FormBuilderLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      theme: ThemeData.light(),
      home: HomePage(),
      // routes: <String,WidgetBuilder>{
      //   '/second':(context)=>CreditCardPage()
      // },
    );
  }
}


