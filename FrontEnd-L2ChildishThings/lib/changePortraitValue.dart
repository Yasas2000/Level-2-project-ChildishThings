import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/portraitEsti.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'app_bar.dart';
import 'configs.dart';

//changing the protrait values
class changePortraitValue extends StatefulWidget {
  const changePortraitValue({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _changePortraitValueState createState() => _changePortraitValueState();
}

class _changePortraitValueState extends State<changePortraitValue> {
  final _formKey = GlobalKey<FormState>();
  final amount = TextEditingController();
  final amount1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
            appBar: CustomAppBar(
              title: 'Change Value',
              leadingIcon: IconButton(
                icon: Icon(Icons.arrow_back_ios_outlined,color: Colors.deepOrange,size: 40,),
                onPressed:(){
                  Navigator.of(context).pop();
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
                ),
              ),
              child: Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      TextFormField(
                        controller: amount,
                        keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                        ],

                        decoration: const InputDecoration(
                          icon: Icon(Icons.money, color: Colors.deepOrange),
                          labelText:
                              'Amount for WITHOUT FRAMES (PHOTO - 6"x8")',
                          hintText: 'Ex.32.45',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.deepOrange,
                            ),
                          ),
                          labelStyle: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 16,
                          ),
                        ),
                        validator: (value) {
                          if (value != null && value.isNotEmpty) {
                            final doubleValue = double.tryParse(value);
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepOrange,
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final response = await http.put(
                              Uri.parse(localhost + '/api/updatePortraitValue'),
                              headers: <String, String>{
                                'Content-Type':
                                    'application/json; charset=UTF-8',
                              },
                              body: jsonEncode(<String, dynamic>{
                                'amount': double.parse(amount.text),
                              }),
                            );
                            if(response.statusCode==200){
                              setState(() {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => changePortraitValue()));
                              });
                            }
                          }
                        },
                        child: Text('Save'),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: amount1,
                        keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
                        ],

                        decoration: const InputDecoration(
                          icon: Icon(Icons.money, color: Colors.deepOrange),
                          labelText: 'Amount for WITH PLYWOOD FRAMES (6"x8")',
                          hintText: 'Ex.32.45',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.deepOrange,
                            ),
                          ),
                          labelStyle: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 16,
                          ),
                        ),
                        validator: (value1) {
                          if (value1 != null && value1.isNotEmpty) {
                            final doubleValue1 = double.tryParse(value1);
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepOrange,
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final response = await http.put(
                              Uri.parse(localhost + '/api/updatePortraitValue1'),
                              headers: <String, String>{
                                'Content-Type':
                                    'application/json; charset=UTF-8',
                              },
                              body: jsonEncode(<String, dynamic>{
                                'amount1': double.parse(amount1.text),
                              }),
                            );
                            if(response.statusCode==200){
                              setState(() {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => changePortraitValue()));
                              });
                            }

                          }
                        },
                        child: Text('Save'),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ));
  }
}
