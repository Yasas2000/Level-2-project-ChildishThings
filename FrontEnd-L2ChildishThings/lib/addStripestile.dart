import 'dart:convert';
import 'package:flutter/material.dart';
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
              image: AssetImage("Asset/new.jpg"),
              fit: BoxFit.cover,
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
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _hour,
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
                    primary: Colors.orange,
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => successful()),
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
