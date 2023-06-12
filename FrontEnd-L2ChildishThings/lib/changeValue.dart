import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'app_bar.dart';
import 'configs.dart';
import 'homepage.dart';

//Changing the custom value

class changeValue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const  MyForm();
  }
}

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  final amount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: CustomAppBar(
              title: 'Change Custom Value',
              leadingIcon: IconButton(
                icon: Icon(
                  Icons.home,
                  color: Colors.deepOrange,
                  size: 40,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomePage()),
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
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
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
                          icon: Icon(Icons.money, color: Colors.orange),
                          labelText: 'Amount',
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
                          if (value!.isEmpty) {
                            return 'Please enter an amount';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter a valid amount in numbers';
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
                              Uri.parse(localhost+'/api/updateCustomValue'),
                              headers: <String, String>{
                                'Content-Type':
                                    'application/json; charset=UTF-8',
                              },
                              body: jsonEncode(<String, dynamic>{
                                'amount': double.parse(amount.text),
                              }),
                            );
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
