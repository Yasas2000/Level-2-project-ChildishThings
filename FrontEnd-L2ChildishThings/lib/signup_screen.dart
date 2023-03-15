// ignore_for_file: unused_import, use_key_in_widget_constructors, prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables, avoid_print, library_private_types_in_public_api, override_on_non_overriding_member, unused_field, unused_element, curly_braces_in_flow_control_structures, prefer_typing_uninitialized_variables, prefer_final_fields, unused_local_variable, non_constant_identifier_names, import_of_legacy_library_into_null_safe, avoid_unnecessary_containers

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/loginscreen.dart';
import 'package:frontend/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';

class SignUpScreen extends StatefulWidget {

  @override
  _SignUpScreenState createState() =>  _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {


  bool _isAdmin = false;
  var role = "User";
  var confirmPass;
  final _formKey = GlobalKey<FormState>();
  
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _confirmPassController = TextEditingController();
  
  

  Future<User> userSignUp(
    String fullName,String email,String phoneNumber,String password,String role) async{
    const url = "http://localhost:5000/users/register";
    Map<String, dynamic> requestPayload = {
      "fullName": fullName,
      "email" : email,
      "phoneNo" : phoneNumber,
      "password" : password,
      "role" : role 
    };

    final http.Response response = await http.post(Uri.parse(url), 
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestPayload));
      
    if(response.statusCode == 201){
        return User.fromJson(json.decode(response.body));
    }else{
        throw Exception("Fail to sign up user");
    }  
  }


  
   @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
        value:SystemUiOverlayStyle.light,
        child: Form(
          key:_formKey,
          child:SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Container(
                  height: 280,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90)),
                    color: new Color(0xffF5591F),
                    gradient: LinearGradient(colors: [(new  Color(0xffF5591F)), new Color(0xffF2861E)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(             
                            child: Image.asset(
                              "assets/photobooth.png",
                              height: 200,
                              width: 200,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(right: 20, top: 10),
                              alignment: Alignment.bottomRight,
                              child: Text(
                                "Sign Up!",
                                style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 2.0,
                                      color: Colors.black,
                                      offset: Offset(1.0, 1.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      )
                  ),
                ),
                
                
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey[200],
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 50,
                          color: Color(0xffEEEEEE)
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: _fullNameController,
                    cursorColor: Color(0xffF5591F),
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: Color(0xffF5591F),
                      ),
                      hintText: "Full Name",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                    validator: validateName,
                  ),
                ),  
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.grey[200],
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 50,
                          color: Color(0xffEEEEEE)
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: _emailController,
                    cursorColor: Color(0xffF5591F),
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.email,
                        color: Color(0xffF5591F),
                      ),
                      hintText: "Email",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                    validator: validateEmail,
                  ),
                ),

                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color(0xffEEEEEE),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 20),
                          blurRadius: 100,
                          color: Color(0xffEEEEEE)
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: _phoneNumberController,
                    cursorColor: Color(0xffF5591F),
                    decoration: InputDecoration(
                      focusColor: Color(0xffF5591F),
                      icon: Icon(
                        Icons.phone,
                        color: Color(0xffF5591F),
                      ),
                      hintText: "Phone Number",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                    validator: validateMobile,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color(0xffEEEEEE),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 20),
                          blurRadius: 100,
                          color: Color(0xffEEEEEE)
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: _passController,
                    obscureText: true,
                    cursorColor: Color(0xffF5591F),
                    decoration: InputDecoration(
                      focusColor: Color(0xffF5591F),
                      icon: Icon(
                        Icons.vpn_key,
                        color: Color(0xffF5591F),
                      ),
                      hintText: "Enter Password",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                    validator: validatePassword,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                  padding: EdgeInsets.only(left: 20, right: 20),
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color(0xffEEEEEE),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 20),
                          blurRadius: 100,
                          color: Color(0xffEEEEEE)
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: _confirmPassController,
                    obscureText: true,
                    cursorColor: Color(0xffF5591F),
                    decoration: InputDecoration(
                      focusColor: Color(0xffF5591F),
                      icon: Icon(
                        Icons.vpn_key,
                        color: Color(0xffF5591F),
                      ),
                      hintText: "Confirm Password",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                    validator: confirmPassword,
                  ),
                ),
                SizedBox(height: 5),
                Container(  
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                  padding: EdgeInsets.only(left: 20, right: 20),
                    child: Column(  
                      children: <Widget>[  
                        Row(  
                          children: <Widget>[  
                            SizedBox(width: 10,),  
                            Text('Sign Up as Admin? ',style: TextStyle(fontSize: 15.0,fontStyle: FontStyle.italic, fontWeight: FontWeight.bold ), ),  
                            Checkbox(  
                              checkColor: Colors.greenAccent,  
                              activeColor: Colors.red,  
                              value: _isAdmin,  
                              onChanged: (value) {  
                                setState(() {  
                                  _isAdmin = value!; 
                                  
                                });  
                              },  
                            ),   
                          ],  
                        ),  
                      ],  
                    )  
                ),  
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if(_formKey.currentState!.validate()){
                          if(_isAdmin){
                                      role = "Admin";
                                  }else{
                                    role = "User";
                                  } 
                          userSignUp(
                            _fullNameController.text,
                            _emailController.text,
                            _phoneNumberController.text,
                            _passController.text,
                            role
                            );
                            QuickAlert.show(
                            context: context, 
                            text: "Congratulations,Your account has been successfully created.Please login",
                            type: QuickAlertType.success,
                            onConfirmBtnTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => LoginScreen()),
                                );
                            },
                          ); 
                          }
                          
                      });  
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 20, right: 20, top: 50),
                    padding: EdgeInsets.only(left: 20, right: 20),
                    height: 54,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [(new  Color(0xffF5591F)), new Color(0xffF2861E)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight
                      ),
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey[200],
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 10),
                            blurRadius: 50,
                            color: Color(0xffEEEEEE)
                        ),
                      ],
                    ),
                    child: Text(
                      "REGISTER",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?  "),
                      GestureDetector(
                        child: Text(
                          "Login Now",
                          style: TextStyle(
                              color: Color(0xffF5591F)
                          ),
                        ),
                        onTap: () {
                          // Write Tap Code Here.
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                )
              ],
            )
          )
        )
      )
    );
    }


    String? validateName(String? value) {
    if (value!.length < 3)
      return 'Name must be more than 2 characters';
    else
      return null;
  }

  String? validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!))
      return 'Enter Valid Email';
    else
      return null;
  }
  String? validateMobile(String? value) {

    if (value!.length != 10)
      return 'Mobile Number must be of 10 digit';
    else
      return null;
  }

  String? validatePassword(String? value){
     confirmPass = value;
      if (value!.isEmpty) {
                            return "Please Enter New Password";
                          } 
      else if (value.length < 8) {
                                  return "Password must be atleast 8 characters long";
      } 
      else {
              return null;
      }
  }

  String? confirmPassword(String? value){
    if (value!.isEmpty) {
          return "Please Re-Enter New Password";
    } 
    else if (value.length < 8) {
        return "Password must be atleast 8 characters long";
    } 
    else if (value != confirmPass) {
        return "Password must be same as above";
    } 
    else {
            return null;
    }
  }
}
  


