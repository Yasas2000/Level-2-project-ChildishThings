import 'package:flutter/material.dart';
import 'package:frontend/app_bar.dart';
import 'package:frontend/credi_card_page.dart';
class Homepage extends StatefulWidget {




  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        'Notifications'
      ),
      body: Center(
        //child: ListView.builder(
            //itemBuilder:(context,index) ),

      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: increment,
      //   child:Icon(Icons.add), ) ,
    );
  }
}