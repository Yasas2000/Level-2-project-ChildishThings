import 'dart:convert';

import 'package:frontend/credi_card_page.dart';
import 'package:frontend/feedback.dart';
import "package:flutter/material.dart";
import 'package:frontend/notifications.dart';
import 'feedback.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;

import 'feedbackpage.dart';
import 'item_page.dart';
enum MenuItem{
  item1,
  item2,
  item3,
  item4,
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
late final String title;

late final Widget? leadingIcon;

  // const CustomAppBar({
  //   Key? key
  // ,required this.title,
  // }) : super(key: key);
CustomAppBar(String title, Widget? lead){
  this.title=title;
  this.leadingIcon=lead;
}
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0.0,
      backgroundColor: Colors.transparent,

      //shape: OutlineInputBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25),bottomRight: Radius.circular(25)),borderSide: BorderSide(color: Colors.deepOrange)),
      automaticallyImplyLeading: false,
      title: Text(title,style: TextStyle(color: Colors.deepOrange),),
      leading:leadingIcon ,

      actions: [

        IconButton(
            icon:Icon(Icons.notifications,color: Colors.deepOrange,),
            iconSize: 40,
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context){
                    return NotificationsPage();
                  }));
            }),
        //   IconButton(
        //   icon:Icon(Icons.more_vert),
        //
        //   onPressed: (){})
        PopupMenuButton<MenuItem>(
            icon: Icon(Icons.drag_indicator,color: Colors.deepOrange,),
            iconSize: 40,
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),side: BorderSide(color: Colors.deepOrange)),
            color: Colors.white,



            onSelected: (value){
              if(value==MenuItem.item1){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context)=> Homepage()));
              }else if(value==MenuItem.item2){

              }else if(value==MenuItem.item3){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                  return FeedbackBar();
                }));

              }

            },

            itemBuilder: (context)=>[

              PopupMenuItem(
                  value: MenuItem.item1,


                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Container(
                        padding: EdgeInsets.only(right: 12.0),
                        decoration: new BoxDecoration(
                            border: new Border(
                                right: new BorderSide(width: 1.0, color: Colors.deepOrange))),
                      child:Icon(Icons.settings,color: Colors.deepOrange,),
                      ),
                      Text(' Settings',style: TextStyle(color: Colors.deepOrange),),

                    ],
                  ),
              ),
              PopupMenuItem(

                  value: MenuItem.item2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 12.0),
                        decoration: new BoxDecoration(
                            border: new Border(
                                right: new BorderSide(width: 1.0, color: Colors.deepOrange))),
                        child:Icon(Icons.help,color: Colors.deepOrange,),
                      ),
                      Text(' Help amd Support',style: TextStyle(color: Colors.deepOrange)),
                    ],
                  )),
              PopupMenuItem(

                  value: MenuItem.item3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 12.0),
                        decoration: new BoxDecoration(
                            border: new Border(
                                right: new BorderSide(width: 1.0, color: Colors.deepOrange))),
                        child:Icon(Icons.feedback,color: Colors.deepOrange,),
                      ),
                      Text(' Feedback',style: TextStyle(color: Colors.deepOrange,)),
                    ],
                  )
              )
            ])
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60.0);


}




