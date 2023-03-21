import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class changePortraitValue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyForm(),
    );
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
  final amount1 = TextEditingController();
  

  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("new.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          body: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20),
                TextFormField(
                  controller:amount,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.money),
                    labelText: 'Amount for WITHOUT FRAMES (PHOTO - 6"x8")',
                    hintText: 'Ex.32.45',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 15, 14, 13),
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
                    primary: Colors.orange,
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final response = await http.put(
                        Uri.parse(
                            'http://localhost:3000/api/updatePortraitValue'),
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
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
                TextFormField(
                  controller: amount1,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.money),
                    labelText: 'Amount for WITH PLYWOOD FRAMES (6"x8")',
                    hintText: 'Ex.32.45',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.orange,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Color.fromARGB(255, 15, 14, 13),
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
                    primary: Colors.orange,
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final response = await http.put(
                        Uri.parse(
                            'http://localhost:3000/api/updatePortraitValue1'),
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body: jsonEncode(<String, dynamic>{
                          'amount1': double.parse(amount1.text),
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
      );
}
