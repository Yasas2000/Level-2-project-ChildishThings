import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/poratraitQuo.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'app_bar.dart';
import 'changePortraitValue.dart';
import 'configs.dart';

//Portrait estimation web page

class portraitEsti extends StatefulWidget {
  final bool isAdmin;

  const portraitEsti({Key? key, required this.isAdmin}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<portraitEsti> {
  int amount1 = 0;
  int amount2 = 0;
  int numOfPhotos = 0;
  int selectedPackage = 1;
  double _price = 0;
  double _size=0;

  void initState() {
    super.initState();
    _getAmounts();
  }

  Future<void> _getAmounts() async {
    final response1 =
        await http.get(Uri.parse(localhost_ + '/getPortraitValue'));
    final response2 =
        await http.get(Uri.parse(localhost_ + '/getPortraitValue1'));
    final data1 = json.decode(response1.body);
    final data2 = json.decode(response2.body);
    setState(() {
      amount1 = data1['amount'];
      amount2 = data2['amount1'];
    });
  }

  int _calculateTotalPrice() {
    if (selectedPackage == 1) {
      return amount1 * numOfPhotos;
    } else if (selectedPackage == 2) {
      return amount2 * numOfPhotos;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        title: 'Portrait Estimation',
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter the Number of photos:',
                style: TextStyle(fontSize: 18.0, color: Colors.orange),
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    numOfPhotos = int.parse(value);
                  });
                },
              ),
              SizedBox(height: 16.0),
              Text(
                'Select the package type:',
                style: TextStyle(fontSize: 14.0, color: Colors.orange),
              ),
              DropdownButton<int>(
                value: selectedPackage,
                onChanged: (value) {
                  setState(() {
                    selectedPackage = value!;
                  });
                },
                items: [
                  DropdownMenuItem<int>(
                    value: 1,
                    child: Text("WITHOUT FRAMES (PHOTO - 6'x8')"),
                  ),
                  DropdownMenuItem<int>(
                    value: 2,
                    child: Text("WITH FRAMES (PHOTO - 6'x8')"),
                  ),
                ],
              ),
              SizedBox(height: 16.0),

              Text(
                'size',
                style: TextStyle(fontSize: 18.0, color: Colors.orange),
              ),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    numOfPhotos = int.parse(value);
                  });
                },
              ),
              Text(
                'Estimated Total Price: Rs ${_calculateTotalPrice()}',

                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange),
              ),
              SizedBox(
                height: 150,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => poratraitQuo()));
                  },
                  child: Text('Get Exact Amount')),
              SizedBox(
                height: 40,
              ),
              Visibility(
                visible: widget.isAdmin == true,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => changePortraitValue()));
                    },
                    child: Text('Change Values')
                    ),
                    
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
