import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:frontend/configs.dart';
import 'package:http/http.dart' as http;

/**
 * This is the feedback page
 */

class FeedbackBar extends StatefulWidget {

  @override
  State<FeedbackBar> createState() => _FeedbackBarState();
}

class _FeedbackBarState extends State<FeedbackBar> {
  double _initialRating = 3.0;
  String UserId='ymeka2000';
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
                    var url=localhost+'/feed';
                    final response = await http.post(
                      Uri.parse(url),
                      headers: {'Content-Type': 'application/json'},
                      body: jsonEncode({'uid':UserId,'rating':_rating.toDouble(),'comment':comment,'dt':DateTime.now().toString()}),
                    );
                    if (response.statusCode == 200) {
                      print('${response.body}');
                      print('${response.statusCode}');
                    } else {
                      print('${response.body}');
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
