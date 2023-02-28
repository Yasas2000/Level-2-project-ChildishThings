
import "package:flutter/material.dart";
import 'feedback.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'item_page.dart';
enum MenuItem{
  item1,
  item2,
  item3,
  item4,
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
late final String title;

  // const CustomAppBar({
  //   Key? key
  // ,required this.title,
  // }) : super(key: key);
CustomAppBar(String title){
  this.title=title;
}
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.deepOrange,
      automaticallyImplyLeading: false,
      title: Text(title),
      leading:IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context,true);
        },
      ) ,
      actions: [

        IconButton(
            icon:Icon(Icons.notifications),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context){
                    return Homepage();
                  }));
            }),
        //   IconButton(
        //   icon:Icon(Icons.more_vert),
        //
        //   onPressed: (){})
        PopupMenuButton<MenuItem>(
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),),
            color: Colors.deepOrange,


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
                  child: Text('Settings',),
              ),
              PopupMenuItem(

                  value: MenuItem.item2,
                  child: Text('Help amd Support')),
              PopupMenuItem(

                  value: MenuItem.item3,
                  child: Text('Feedback'))
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


  @override
  void initState() {
    super.initState();

  }
  late double _rating=3.0;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      title: Container(
        child: Text(
          'Rate Us',

          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold,

              color: Colors.white,
              fontSize: 30.0


          ),

        ),
      ),
      backgroundColor: Colors.deepOrange,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),

      ),

      titlePadding: EdgeInsets.all(12.0),
      contentPadding: EdgeInsets.all(10),
      content: Column(

        mainAxisSize: MainAxisSize.min,

        children:<Widget> [
          SizedBox(
            height: 40.0,
          ),

          Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),


              child: _ratingBar()
          , ),
          SizedBox(height: 40.0),
          Text(
            'Rating: $_rating',
            style: TextStyle(fontWeight: FontWeight.bold ),

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
                      primary: Color(0xFFFFFFFF)
                  ),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                    child: Text(
                      'Later',
                      style: TextStyle(
                        color: Colors.deepOrange,
                        fontFamily: 'halter',
                        fontSize: 14,
                      ),
                    ),


                  ),
                ),
                ElevatedButton(onPressed: (){
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context)=> AlertBox()));




                },
                  style: ElevatedButton.styleFrom(

                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)
                      ),
                      primary: Color(0xFFFFFFFF)
                  ),
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    child: Text(
                      'Confirm',
                      style: TextStyle(
                        color: Colors.deepOrange,
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
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),

      ),

      titlePadding: EdgeInsets.all(12.0),
      contentPadding: EdgeInsets.all(20),
     backgroundColor: Colors.deepOrange,
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
              primary: Color(0xFFFFFFFF)
          ),
          child: Container(
            margin: EdgeInsets.all(8.0),
            child: Text(
              'Contnue',
              style: TextStyle(
                color: Colors.deepOrange,
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



