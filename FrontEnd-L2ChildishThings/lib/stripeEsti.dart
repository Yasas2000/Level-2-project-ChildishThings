import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:myproject/stripsQuo.dart';
import 'package:myproject/addStripestile.dart';
import 'package:myproject/appbar.dart';

//Stripes estimation web page

class stripeEsti extends StatelessWidget {
  final String amount;
  final String hour;
  const stripeEsti({required this.amount, required this.hour});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: CustomAppBar(
          title: 'Stripes Estimation',
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
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
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
                      Text(
                        "Estimated price is",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "LKR $amount",
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Unlimited Photo Strips for $hour Hour/s.",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 15),
                      Text(
                        "Click the link below to get a custom quotation with ongoing discounts and promotions.\nWe highly recommend you to place a free booking to reserve the date and to avoid any \nprice fluctuations.",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 20),
                      InkWell(
                        child: const Text(
                          'GET THE EXACT AMOUNT',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => stripsQuo()),
                          );
                        },
                      ),
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
