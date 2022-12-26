import 'package:device_preview/device_preview.dart';
import "package:flutter/material.dart";
import "credi_card_page.dart";
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

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: CreditCardPage(),
    );
  }
}


