import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/stripeEsti.dart';
import 'package:frontend/successful.dart';
import 'package:http/http.dart' as http;
import 'app_bar.dart';
import 'configs.dart';

//Adding photo stripes

class AddPhotoTileScreen extends StatefulWidget {
  @override
  _AddPhotoTileScreenState createState() => _AddPhotoTileScreenState();
}

class _AddPhotoTileScreenState extends State<AddPhotoTileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _imageAssets = TextEditingController();
  final _text = TextEditingController();
  final _amount = TextEditingController();
  final _hour = TextEditingController();
  late final bool _isAdmin;

  void _showStripeEstimate(String amount, String hour) {
    Navigator.push(
      context as BuildContext,
      MaterialPageRoute(
        builder: (context) => stripeEsti(amount: amount, hour: hour),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'Add Stripe Tile',
          leadingIcon: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.deepOrange,
              size: 40,
            ),
            onPressed: () {
              Navigator.pop(context);
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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 40),
                TextFormField(
                  controller: _imageAssets,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.image, color: Colors.orange),
                    labelText: 'Image Name',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.orange,
                      fontSize: 16,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter the image name";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _text,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.text_format, color: Colors.orange),
                    labelText: 'Text',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.orange,
                      fontSize: 16,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter text";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _amount,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.money, color: Colors.orange),
                    labelText: 'Amount',
                    hintText: 'Ex:31,365.00',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.orange,
                      fontSize: 16,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter the amount";
                    }
                    return null;
                  },
                  keyboardType:
                  TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                  ],

                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _hour,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],

                  decoration: const InputDecoration(
                    icon: Icon(Icons.cloud_circle, color: Colors.orange),
                    labelText: 'Hours',
                    hintText: 'Ex:2',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.orange,
                      fontSize: 16,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter the hours";
                    }
                    return null;
                  },

                ),
                SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepOrange,
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final response = await http.post(
                        Uri.parse(localhost + '/api/addStripTile'),
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body: jsonEncode(<String, dynamic>{
                          'imageAsset': _imageAssets.text,
                          'text': _text.text,
                          'amount': _amount.text,
                          'hour': _hour.text,
                        }),
                      );
                      if (response.statusCode == 200) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => successful()),(route) => false,
                        );
                      }
                    }
                    }, child: Text('Add'),

                    
                ),
              ],
            ),
          ),
        ));
  }
}
