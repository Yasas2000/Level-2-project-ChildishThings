// ignore_for_file: unused_import, use_key_in_widget_constructors, prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables, avoid_print, library_private_types_in_public_api, override_on_non_overriding_member, unused_field, unused_element, curly_braces_in_flow_control_structures, prefer_typing_uninitialized_variables, prefer_final_fields, unused_local_variable, non_constant_identifier_names, import_of_legacy_library_into_null_safe

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/verification.dart';
import 'package:frontend/models/user.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {

  @override
  _SignUpScreenState createState() =>  _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  
  var confirmPass;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _confirmPassController = TextEditingController();
  
  

  Future<User> userSignUp(
    String firstName, String lastName,String email,String phoneNumber,String password) async{
    const url = "http://localhost:1000/api/user/signup";
    Map<String, dynamic> requestPayload = {
      "firstName": firstName,
      "lastName" : lastName,
      "email" : email,
      "phoneNumber" : phoneNumber,
      "password" : password 
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
  Widget buildCreateAccBtn(){
      return Container(
          padding: EdgeInsets.symmetric(vertical: 25),
          width: double.infinity,
          child: ElevatedButton(
                  onPressed: ()  {             
                      setState(() {
                      if(_formKey.currentState!.validate()){
                          userSignUp(
                            _firstNameController.text,
                            _lastNameController.text,
                            _emailController.text,
                            _phoneNumberController.text,
                            _passController.text,
                            );
                            Navigator.pop(context);
                          }
                          
                      });                                                                           
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                    )
                  ),
                  child: Text(
                      'CONTINUE',
                      style: TextStyle(
                        color: Color.fromARGB(255, 3, 44, 110),
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                ),
      );
    }
  
  Widget buildSigninBtn(){
      return GestureDetector(
          onTap: () => {
            Navigator.pop(context)
          },
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Already Member? ',
                  style: TextStyle(
                  color: Color.fromARGB(255, 254, 254, 254),
                  fontSize: 16,
                  fontWeight: FontWeight.w500
                ),
                ),
                TextSpan(
                  text: 'Login Now',
                  style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                  ), 
                ),
              ]
          ),
        ),
      );
    }
  
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value:SystemUiOverlayStyle.light,
        child:Form(
              key: _formKey,
              child:GestureDetector(
                    child:Stack(         
                        children: <Widget>[
                            Container(                             
                                height: double.infinity,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end:Alignment.bottomCenter,
                                        colors:[
                                            Color(0x660048ba),
                                            Color(0x990048ba),
                                            Color(0xcc0048ba),
                                            Color(0xff0048ba),
                                        ]
                                    )
                                ),
                               child: SingleChildScrollView(
                                physics: AlwaysScrollableScrollPhysics(),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 25,
                                  vertical: 120
                                ),
                                 child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:<Widget>[
                                      Text(
                                            'Create Account',
                                            style:TextStyle(
                                               color: Colors.white,
                                               fontSize: 40,
                                               fontWeight: FontWeight.bold     
                                            ),
                                        ),
                                        SizedBox(height: 30),
                                        Row(
                                          children: [
                                              Expanded(
                                                flex: 3,                   
                                                child: ListTile(
                                                  subtitle: TextFormField(   
                                                    controller: _firstNameController,
                                                    keyboardType: TextInputType.text,      
                                                    cursorColor: Color(0xcc0048ba),                                                          
                                                    decoration:  InputDecoration(
                                                      prefixIcon: Icon(Icons.person,color: Color(0xff0048ba)),
                                                      filled: true,
                                                      fillColor: Colors.grey[200],
                                                      border: OutlineInputBorder(
                                                        borderSide: BorderSide.none,
                                                        borderRadius: BorderRadius.circular(50),                      
                                                      ),                                               
                                                      hintText: "First Name",                                              
                                                    ),
                                                    validator: validateName,
                                                  ),
                                                ),
                                              ),                                         
                                              Expanded(
                                                flex: 4,
                                                child: ListTile(
                                                  subtitle: TextFormField(
                                                    controller: _lastNameController,
                                                    keyboardType: TextInputType.text,
                                                    cursorColor: Color(0xcc0048ba),
                                                    decoration: InputDecoration(
                                                      filled: true,
                                                      fillColor: Colors.grey[200],
                                                      border: OutlineInputBorder(
                                                        borderSide: BorderSide.none,
                                                        borderRadius: BorderRadius.circular(50),                      
                                                      ), 
                                                      hintText: "Last Name",      
                                                    ),
                                                    validator: validateName,
                                                  ),
                                                ),
                                              ),
                                            ],
                                        ),  
                                      Container(
                                        margin: EdgeInsets.only(left: 20,right: 20,top: 40),
                                        padding: EdgeInsets.only(left: 20,right: 20),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          color: Colors.grey[200],
                                          boxShadow: [BoxShadow(
                                            offset: Offset(0,10),
                                            blurRadius: 50,
                                            color: Color(0xB3EEEEEE)
                                          )],
                                        ),
                                        alignment: Alignment.center,
                                        child: TextFormField(
                                          controller: _emailController,
                                          keyboardType: TextInputType.emailAddress ,
                                          cursorColor: Color(0xcc0048ba),
                                          decoration: InputDecoration(
                                            icon: Icon(
                                              Icons.email,
                                              color: Color(0xff0048ba),
                                            ),
                                            hintText: "Enter Email",
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none
                                          ),
                                          validator: validateEmail,
                                        ), 
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 20,right: 20,top: 40),
                                        padding: EdgeInsets.only(left: 20,right: 20),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          color: Colors.grey[200],
                                          boxShadow: [BoxShadow(
                                            offset: Offset(0,10),
                                            blurRadius: 50,
                                            color: Color(0xB3EEEEEE)
                                          )],
                                        ),
                                        alignment: Alignment.center,
                                        child: TextFormField(
                                          controller: _phoneNumberController,
                                          keyboardType: TextInputType.phone,
                                          cursorColor: Color(0xcc0048ba),
                                          decoration: InputDecoration(
                                            icon: Icon(
                                              Icons.phone,
                                              color: Color(0xff0048ba),
                                            ),
                                            hintText: "Phone Number",
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none
                                          ),
                                          validator: validateMobile,
                                        ), 
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 20,right: 20,top: 40),
                                        padding: EdgeInsets.only(left: 20,right: 20),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          color: Colors.grey[200],
                                          boxShadow: [BoxShadow(
                                            offset: Offset(0,10),
                                            blurRadius: 50,
                                            color: Color(0xB3EEEEEE)
                                          )],
                                        ),
                                        alignment: Alignment.center,
                                        child: TextFormField(
                                          controller: _passController,
                                          keyboardType: TextInputType.text,
                                          obscureText: true,
                                          cursorColor: Color(0xcc0048ba),
                                          decoration: InputDecoration(
                                            icon: Icon(
                                              Icons.lock,
                                              color: Color(0xff0048ba),
                                            ),
                                            hintText: "Password",
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none
                                          ),
                                          validator: validatePassword,
                                        ), 
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 20,right: 20,top: 40),
                                        padding: EdgeInsets.only(left: 20,right: 20),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          color: Colors.grey[200],
                                          boxShadow: [BoxShadow(
                                            offset: Offset(0,10),
                                            blurRadius: 50,
                                            color: Color(0xB3EEEEEE)
                                          )],
                                        ),
                                        alignment: Alignment.center,
                                        child: TextFormField(
                                          controller: _confirmPassController,
                                          keyboardType: TextInputType.text,
                                          obscureText: true,
                                          cursorColor: Color(0xcc0048ba),
                                          decoration: InputDecoration(
                                            icon: Icon(
                                              Icons.lock,
                                              color: Color(0xff0048ba),
                                            ),
                                            hintText: "Confirm Password",
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none
                                          ),
                                          validator: confirmPassword,
                                        ), 
                                      ),
                                      SizedBox(height: 30),
                                      buildCreateAccBtn(),
                                      buildSigninBtn(),
                                    ],
                                  ),
                               ),
                            ),
                        ],
                    ),
                ),),
                
            ),
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
  


