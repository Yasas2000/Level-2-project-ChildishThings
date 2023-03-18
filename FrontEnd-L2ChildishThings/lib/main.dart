import 'package:device_preview/device_preview.dart';
import "package:flutter/material.dart";
import 'package:mypart/donation_form.dart';
import "credi_card_page.dart";
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:form_validator/form_validator.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

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
      home: DonationForm(),
      // routes: <String,WidgetBuilder>{
      //   '/second':(context)=>CreditCardPage()
      // },
    );
  }
}


