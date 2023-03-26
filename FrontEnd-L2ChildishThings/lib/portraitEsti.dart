import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/poratraitQuo.dart';
import 'package:frontend/changePortraitValue.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class portraitEsti extends StatefulWidget {
   final bool isAdmin;

  const portraitEsti({Key? key, required this.isAdmin}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<portraitEsti> {
  double _photo = 0;
  double _price = 0;
  double amount = 0;
  double amount1 = 0;
  bool isAmountSelected = true;
  

  void initState() {
    super.initState();
    fetchUpdatedAmount();
  }

  Future<void> fetchUpdatedAmount() async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/api/getPortraitValue'));
        
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        amount = data['amount'];
        amount1 = data['amount1'];
      });
    } else {
      throw Exception('Failed to fetch updated amount');
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedPrice = NumberFormat('###,###.##').format(_price);
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Portrait Pricing Calculator"),
      ),
      body: Container(
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
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Ex:50 photos',
                        labelText: "Enter the Number of photos",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange))),
                    onChanged: (value) {
                      if (value.isEmpty) {
                        setState(() {
                          _photo = 0;
                          _price = 0;
                        });
                      } else if (double.tryParse(value) != null) {
                        setState(() {
                          _photo = double.parse(value);
                          _price = _photo * amount;
                        });
                      } else {
                        print("Invalid input");
                      }
                    },
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(height: 15),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  items: [
                    DropdownMenuItem(
                      child: Text("Select the package type"),
                      value: 0,
                      
                    ),
                    DropdownMenuItem(
                      child: Text("WITHOUT FRAMES (PHOTO - 6'x8')"),
                      value: amount 
                    ),
                    DropdownMenuItem(
                      child: Text("WITH PLYWOOD FRAMES (6'x8;)"),
                      value: amount1 
                    ),
                  ],
                  hint: Text('Select the package type'),
                    onChanged: (value) {
                    setState(() {
                      if (value == amount1) {
                        isAmountSelected = true;
                        _price = _photo * amount1;
                      } else if (value == amount) {
                        isAmountSelected = false;
                        _price = _photo * amount;
                      }
                    });
                  },

                  
                ),
              ],
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Estimated Price: \Rs.$formattedPrice",
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
            widget.isAdmin
                    ?
            InkWell(
              child: const Text(
                'Click here to change the values',
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
                      builder: (context) => changePortraitValue()),
                );
              },
            ):
            
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
                  MaterialPageRoute(builder: (context) => poratraitQuo()),
                );
              },
            ),
          ],
        ),
      ),
    ));
  }
}
