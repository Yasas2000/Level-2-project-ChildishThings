// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, sort_child_properties_last, unused_local_variable, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:frontend/services/user_api_service.dart';
import 'package:frontend/models/user.dart';
import 'package:bcrypt/bcrypt.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  Future<User> updateUser(String id, Map<String, dynamic> data) async {
    final res = await http.put(Uri.parse(url + id), body: json.encode(data));

    if (res.statusCode == 200) {
      return User.fromJson(json.decode(res.body));
    } else {
      throw Exception('Fail to update users');
    }
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 200,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade200,
                ),
                child: Transform.rotate(
                  angle: 0,
                  child: Image(
                    image: AssetImage('assets/passreset.png'),
                  ),
                ),
              ),
              SizedBox(height: 32.0),
              Text(
                "Reset Your Password",
                style: TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'Montserrat',
                  shadows: [
                    Shadow(
                      blurRadius: 2.0,
                      color: Colors.grey.withOpacity(0.8),
                      offset: Offset(0.0, 2.0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.0),
              Form(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 30, right: 30, bottom: 20),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: "Email",
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 30, right: 30, bottom: 20),
                      child: Stack(
                        children: [
                          TextFormField(
                            controller: _passController,
                            decoration: InputDecoration(
                              hintText: "Password",
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                            ),
                            obscureText: _obscureText,
                          ),
                          Positioned(
                            right: 20,
                            bottom: 15,
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => _obscureText = !_obscureText),
                              child: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey[400],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 30, right: 30, bottom: 20),
                      child: Stack(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Confirm Password",
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25),
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                            ),
                            obscureText: _obscureText,
                          ),
                          Positioned(
                            right: 20,
                            bottom: 15,
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => _obscureText = !_obscureText),
                              child: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey[400],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        margin:
                            EdgeInsets.only(left: 30, right: 30, bottom: 20),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 32.0, vertical: 16.0),
                          ),
                          child: Text(
                            "Reset Password",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
