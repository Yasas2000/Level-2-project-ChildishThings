import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:frontend/stripsQuo.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;


import 'app_bar.dart';
import 'changeValue.dart';
import 'configs.dart';

//Custom web page 

class custom extends StatefulWidget {
  final bool isAdmin;

  custom({required this.isAdmin});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<custom> {
  double _hours = 0;
  double _price = 0;
  double amount = 0;

  @override
  void initState() {
    super.initState();
    fetchUpdatedAmount();
  }

  Future<void> fetchUpdatedAmount() async {
    final response =
        await http.get(Uri.parse(localhost_+'/getCustomValue'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        amount = data['amount'];
        debugPrint(amount as String?);
      });
    } else {
      throw Exception('Failed to fetch updated amount');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: CustomAppBar(
          title: 'Custom',
          leadingIcon: IconButton(
            icon: Icon(
              Icons.home,
              color: Colors.deepOrange,
              size: 40,
            ),
            onPressed: () {},
          ),
        ),
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
              Image.asset(
                'logo.png',
                width: 200,
                height: 200,
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Ex:2.5 hours',
                      labelText: "Enter the Number of hours",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.orange,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.isEmpty) {
                        setState(() {
                          _hours = 0;
                          _price = 0;
                        });
                      } else if (double.tryParse(value) != null) {
                        setState(() {
                          _hours = double.parse(value);
                          _price = _hours * amount;
                          log(_price);
                        });
                      } else {
                        print("Invalid input");
                      }
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Estimated Price: \Rs.$_price",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
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
                    MaterialPageRoute(builder: (context) => stripsQuo()),
                  );
                },
              ),
              Visibility(
                  visible: widget.isAdmin,
                  child: InkWell(
                    child: const Text(
                      'Click here to change the value',
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
                        MaterialPageRoute(builder: (context) => changeValue()),
                      );
                    },
                  )),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
