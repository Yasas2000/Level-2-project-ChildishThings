import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class changeValue extends StatelessWidget {
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
                  controller: amount,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.money),
                    labelText: 'Amount',
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
                    primary: Colors.orange,
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final response = await http.put(
                        Uri.parse('http://localhost:3000/api/updateCustomValue'),
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
              ],
            ),
          ),
        ),
      );
}
