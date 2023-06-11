import 'package:flutter/material.dart';
import 'package:frontend/stripes.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_bar.dart';

//successful display after adding a stripe tile successfully

class successful extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: CustomAppBar(
          title: 'Successful',
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
              image: AssetImage("Asset/new.jpg"),
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
                        'Asset/logo.png',
                        width: 200,
                        height: 200,
                      ),
                      SizedBox(height: 20),
                      Text("Stripe is added successfully!",
                          style: TextStyle(
                            color: Colors.orange,
                            fontSize: 28,
                          )),
                      ElevatedButton(onPressed:() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Stripes()),
                        );
                      },
                        child: Text('Next'),
                        style: ElevatedButton.styleFrom(primary: Colors.orange),

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
