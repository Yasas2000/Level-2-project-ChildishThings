import 'dart:convert';
import 'package:frontend/stripeEsti.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'configs.dart';
import 'login_state.dart';

//The components and the features of a strip tile 

class PhotoTile extends StatelessWidget {
  final String id;
  final String imageAsset;
  final String text;
  final String amount;
  final String hour;
  final VoidCallback onDelete;

  PhotoTile({
    required this.id ,
    required this.imageAsset ,
    required this.text ,
    required this.amount,
    required this.hour ,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final loginState=Provider.of<LoginState>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    return  Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0),
                bottomLeft: Radius.circular(25.0),
                bottomRight: Radius.circular(25.0),
              ),
              border: Border.all(
                color: Colors.deepOrange,
                width: 4,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 6,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          stripeEsti(amount: amount, hour: hour)),
                );
              },
              child: Image.asset(
                'Asset/'+imageAsset,
                width: 0.4 * screenWidth,
                height: 0.4 * screenWidth,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              text,
              style: TextStyle(
                color: Colors.deepOrange,
                fontSize: 10,
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Visibility(
            visible: loginState.role=="admin",
            child: IconButton(
              icon: Icon(Icons.delete),
              color: Colors.red,
              onPressed: () async {
                var request = http.Request(
                    'DELETE', Uri.parse(localhost + '/api/deleteStripes'));
                print("success");
                request.headers['Content-Type'] =
                    'application/json; charset=UTF-8';
                request.body = json.encode({'text': text});

                final response = await http.Client().send(request);

                if (response.statusCode == 200) {
                  onDelete();
                } else {
                  // Handle the error and show an error message
                }
              },
            ),
          ),
        ],
      );
  }
}
