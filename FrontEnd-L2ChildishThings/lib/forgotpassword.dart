// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, sort_child_properties_last, unused_local_variable, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:frontend/services/user_api_service.dart';
import 'package:frontend/models/user.dart';
import 'package:bcrypt/bcrypt.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  
  UserApiService apiService = UserApiService();

  
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
              Text(
                "Forgot Password",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 32.0,
              ),
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
                            controller: _passController ,
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
                      margin: EdgeInsets.only(left: 30, right: 30, bottom: 20),
                      child: ElevatedButton(
                        child: Text(
                          "Reset Password",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        onPressed: () async{
                          String email = _emailController.text;
                          String password = _passController.text;
                          final String hashed = BCrypt.hashpw('password', BCrypt.gensalt());
                          User? user = await apiService.findUserByEmail(email);
                          if(user != null){ 
                              String userId = user.id;
                              Map<String, dynamic> data = {'password': hashed};
                              apiService.updateUser(userId, data);
                          }else{
                            // ignore: avoid_print
                            print("user not found");
                          }                
                        },
                      ),
                    ),
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
