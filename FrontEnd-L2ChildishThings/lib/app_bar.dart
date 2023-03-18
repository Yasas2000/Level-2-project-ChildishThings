import 'dart:convert';

import 'package:mypart/credi_card_page.dart';
import 'package:mypart/feedback.dart';
import "package:flutter/material.dart";
import 'package:mypart/notifications.dart';
import 'feedback.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;

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

class FeedbackBar extends StatefulWidget {

  @override
  State<FeedbackBar> createState() => _FeedbackBarState();
}

class _FeedbackBarState extends State<FeedbackBar> {
  double _initialRating = 3.0;
  String ?comment;


  @override
  void initState() {
    super.initState();

  }
  late double _rating=3.0;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      title: Container(
        decoration: BoxDecoration(borderRadius:BorderRadius.all(Radius.circular(20)),border: Border.all(color: Colors.deepOrange)),
        height: 60,
        padding: EdgeInsets.only(top: 10),
        child: Text(
          'Rate Us',
          textAlign: TextAlign.center,
          style: TextStyle(

              color: Colors.deepOrange,
              fontSize: 30.0


          ),

        ),
      ),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(color: Colors.deepOrange,width: 5)

      ),
      scrollable:true,

      titlePadding: EdgeInsets.all(12.0),
      contentPadding: EdgeInsets.all(10),

      content: Column(

        mainAxisSize: MainAxisSize.min,

        children:<Widget> [
          SizedBox(
            height: 20.0,
          ),

          Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),


              child: _ratingBar()
          , ),
          SizedBox(height: 20.0),
          Text(
            'Rating: $_rating',
            style: TextStyle(fontWeight: FontWeight.bold ),

          ),
          Container(
            padding: EdgeInsets.all(20),
            child: TextFormField(
              maxLength: 200,
               //expands: true,
               maxLines: null,
               scrollController: ScrollController(keepScrollOffset:true),
               cursorColor: Colors.deepOrange,
              decoration: InputDecoration(
                
              floatingLabelAlignment: FloatingLabelAlignment.center,
              hintText: 'What is your opinion?',
              label: Text('Comments',style: TextStyle(color: Colors.deepOrange),),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5),borderSide:BorderSide(color: Colors.deepOrange) ),


            ),
            onChanged: (data){
               setState(() {
                 comment=data;
               });
            },
            keyboardType: TextInputType.text,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context){
                    return AlertBox();
                  }));




                },
                  style: ElevatedButton.styleFrom(

                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)
                      ),
                      backgroundColor: Colors.deepOrange
                  ),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                    child: Text(
                      'Later',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'halter',
                        fontSize: 14,
                      ),
                    ),


                  ),
                ),
                ElevatedButton(onPressed: () async {
                  print(comment);
                  try {
                    var url='http://192.168.1.6:3000/feed';
                    final response = await http.post(
                      Uri.parse(url),
                      headers: {'Content-Type': 'application/json'},
                      body: jsonEncode({'uid':'','rating':_rating.toDouble(),'comment':comment,'dt':DateTime.now().toString()}),
                    );
                    print('${response.body}');
                    print('${response.statusCode}');
                    if (response.statusCode == 200) {

                    } else {

                    }
                  } catch (e) {
                   print(e);
                  }
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context)=> AlertBox()));




                },
                  style: ElevatedButton.styleFrom(

                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)
                      ),
                      backgroundColor: Colors.deepOrange
                  ),
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    child: Text(
                      'Confirm',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'halter',
                        fontSize: 14,
                      ),
                    ),


                  ),
                ),
              ],
            ),
          ),
        ],


      ),

    );
  }
  Widget _ratingBar() {


    return RatingBar.builder(
      initialRating: _initialRating,
      unratedColor: Colors.blueGrey,
      direction:  Axis.horizontal,
      glow: false,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return Icon(
              Icons.sentiment_very_dissatisfied,
              color: Colors.red,
            );
          case 1:
            return Icon(
              Icons.sentiment_dissatisfied,
              color: Colors.redAccent,
            );
          case 2:
            return Icon(
              Icons.sentiment_neutral,
              color: Colors.amber,
            );
          case 3:
            return Icon(
              Icons.sentiment_satisfied,
              color: Colors.lightGreen,
            );
          case 4:
            return Icon(
              Icons.sentiment_very_satisfied,
              color: Colors.green,
            );
          default:
            return Container();
        }
      },
      onRatingUpdate: (rating) {
        setState(() {
          _rating = rating;
        });
      },
      updateOnDrag: true,
    );

  }


}
class AlertBox extends StatefulWidget {
  const AlertBox({Key? key}) : super(key: key);

  @override
  State<AlertBox> createState() => _AlertBoxState();
}

class _AlertBoxState extends State<AlertBox> {

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title:Text(
        'Thank You',
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.deepOrange,),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.deepOrange,width: 5)


      ),

      titlePadding: EdgeInsets.all(12.0),
      contentPadding: EdgeInsets.all(20),
     backgroundColor: Colors.white,
     content:
      Container(

        margin: EdgeInsets.symmetric(vertical: 20),
        child:
        ElevatedButton(onPressed: (){
          Navigator.pop(context,true);


        },
          style: ElevatedButton.styleFrom(

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)
              ),
              backgroundColor: Colors.deepOrange
          ),
          child: Container(
            margin: EdgeInsets.all(8.0),
            child: Text(
              'Contnue',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'halter',
                fontSize: 14,
              ),
            ),

          ),
        ),
      ),

    );
  }
}



