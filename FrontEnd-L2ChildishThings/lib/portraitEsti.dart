import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/poratraitQuo.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'app_bar.dart';
import 'changePortraitValue.dart';
import 'configs.dart';
import 'homepage.dart';
import 'login_state.dart';

//Portrait estimation web page

class portraitEsti extends StatefulWidget {

  const portraitEsti({Key? key}) : super(key: key);
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
        await http.get(Uri.parse(localhost + '/api/getPortraitValue'));
    final response2 =
        await http.get(Uri.parse(localhost + '/api/getPortraitValue1'));
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
    final loginState=Provider.of<LoginState>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        title: 'Portrait Estimation',
        leadingIcon: IconButton(
          icon: Icon(
            Icons.home,
            color: Colors.deepOrange,
            size: 40,
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage()),
                    (route)=>false
            );
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("Asset/new.jpg"),
            fit: BoxFit.cover,
            opacity: 0.5
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (value) {
                  setState(() {
                    numOfPhotos = int.tryParse(value) ?? 0;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Enter the Number of photos:',
                  labelStyle: TextStyle(
                    fontSize: 18.0,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Select the package type:',
                style: TextStyle(fontSize: 14.0, color: Colors.deepOrange),
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
                'Estimated Total Price: Rs ${_calculateTotalPrice()}',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange),
              ),
              SizedBox(
                height: 150,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => poratraitQuo()));
                },
                child: Text('Get Exact Amount'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepOrange,alignment: Alignment.center // Set the background color to orange
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Visibility(
                visible: loginState.role == 'Admin',
                child: ElevatedButton(
                    style: ButtonStyle(alignment: Alignment.center,),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => changePortraitValue()));
                    },
                    child: Text('Change Values')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
