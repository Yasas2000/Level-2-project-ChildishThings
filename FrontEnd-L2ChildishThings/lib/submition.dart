import 'package:flutter/material.dart';
import 'package:frontend/homepage.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_bar.dart';

//Submission successful display after filling the quotation

class submition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("Asset/new.jpg"),
              fit: BoxFit.cover,
              opacity: 0.5
            ),
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'Asset/logo.png',
                        width: 200,
                        height: 200,color: Colors.deepOrange,
                      ),
                      SizedBox(height: 20),
                      Text("Submission Successful!",
                          style: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 28,
                          )),
                      ElevatedButton(onPressed:() {
                        Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                      builder: (context) => HomePage()),(route) => false,
                      );
                        },
                          child: Text('Next'),
                          style: ElevatedButton.styleFrom(primary: Colors.deepOrange),

                          )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
  }
}
