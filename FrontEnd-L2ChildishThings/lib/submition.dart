import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:myproject/appbar.dart';

//Submission successful display after filling the quotation

class submition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: CustomAppBar(
          title: 'Submission',
          leadingIcon: IconButton(
            icon: Icon(
              Icons.home,
              color: Colors.deepOrange,
              size: 40,
            ),
            onPressed: () {},
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("new.jpg"),
              fit: BoxFit.cover,
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
                        'logo.png',
                        width: 200,
                        height: 200,
                      ),
                      SizedBox(height: 20),
                      Text("Submission Successful!",
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 28,
                          )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
