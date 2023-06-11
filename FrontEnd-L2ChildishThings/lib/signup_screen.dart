// ignore_for_file: unused_import, use_key_in_widget_constructors, prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables, avoid_print, library_private_types_in_public_api, override_on_non_overriding_member, unused_field, unused_element, curly_braces_in_flow_control_structures, prefer_typing_uninitialized_variables, prefer_final_fields, unused_local_variable, non_constant_identifier_names, import_of_legacy_library_into_null_safe, avoid_unnecessary_containers

import 'dart:convert';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/configs.dart';
import 'package:frontend/loginscreen.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/signUp_otp.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';

import 'app_bar.dart';
import 'homepage.dart';
import 'otp_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  EmailOTP myauth = EmailOTP();
  var role = "User";
  var confirmPass;
  bool _obscureText = true;
  bool _obscureTextCp = true;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _confirmPassController = TextEditingController();

  Future<Future> userSignUp(String fullName, String email, String phoneNumber,
      String password, String role) async {
    var url = localhost_+"/users/register";
    Map<String, dynamic> requestPayload = {
      "fullName": fullName,
      "email": email,
      "phoneNo": phoneNumber,
      "password": password,
      "role": role
    };

    final http.Response response = await http.post(Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestPayload));

    if (response.statusCode == 200) {
      return QuickAlert.show(
        context: context,
        barrierColor: Colors.transparent,
        text:
        "Congratulations,Your account has been successfully created.Please login",
        type: QuickAlertType.success,
        confirmBtnColor: Colors.green,
        onConfirmBtnTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LoginScreen()),
          );
        },
      );
    } else {
      QuickAlert.show(
        context: context,
        barrierColor: Colors.transparent,
        text:"The Email Already Existed",
        type: QuickAlertType.error,
        confirmBtnColor: Colors.red,
        onConfirmBtnTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LoginScreen()),
          );
        },
      );
      throw Exception("Fail to sign up user");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
            title: '',
            leadingIcon: IconButton(
              icon: Icon(Icons.home),
              iconSize: 40,
              color: Colors.deepOrange,
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => HomePage()));
              },
            )),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Container(
                          height: 280,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(90)),
                            color: new Color(0xffF5591F),
                            gradient: LinearGradient(
                              colors: [
                                (new Color(0xffF5591F)),
                                new Color(0xffF2861E)
                              ],
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
                                  "Asset/Photobooth.png",
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
                          )),
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
                                  color: Color(0xffEEEEEE)),
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
                                  color: Color(0xffEEEEEE)),
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
                                  color: Color(0xffEEEEEE)),
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
                                color: Color(0xffEEEEEE),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              TextFormField(
                                controller: _passController,
                                obscureText: _obscureText,
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
                              Positioned(
                                right: 20,
                                bottom: 15,
                                child: GestureDetector(
                                  onTap: () => setState(
                                      () => _obscureText = !_obscureText),
                                  child: Icon(
                                    _obscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ),
                            ],
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
                                color: Color(0xffEEEEEE),
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              TextFormField(
                                controller: _confirmPassController,
                                obscureText: _obscureTextCp,
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
                              Positioned(
                                right: 20,
                                bottom: 15,
                                child: GestureDetector(
                                  onTap: () => setState(
                                      () => _obscureTextCp = !_obscureTextCp),
                                  child: Icon(
                                    _obscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                UserDetails user=UserDetails(_fullNameController.text, _emailController.text,_phoneNumberController.text,_passController.text,role);
                                myauth.setConfig(
                                  appEmail: "contact@hdevcoder.com",
                                  appName: "Email OTP",
                                  userEmail: _emailController.text,
                                  otpLength: 4,
                                  otpType: OTPType.digitsOnly,
                                );
                                if (await myauth.sendOTP() == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                              content: Text("OTP has been sent"),
                              ),
                              );
                              Navigator.push(context,
                                        MaterialPageRoute(
                                        builder: (context) => SignUPOTPScreen(myauth: myauth, user: user,),
                              ),
                              );
                              } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                              content: Text("Oops, OTP send failed"),
                              ),
                              );
                              }
                              }

                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin:
                                EdgeInsets.only(left: 20, right: 20, top: 50),
                            padding: EdgeInsets.only(left: 20, right: 20),
                            height: 54,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    (new Color(0xffF5591F)),
                                    new Color(0xffF2861E)
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight),
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.grey[200],
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 10),
                                    blurRadius: 50,
                                    color: Color(0xffEEEEEE)),
                              ],
                            ),
                            child: Text(
                              "REGISTER",
                              style: TextStyle(color: Colors.white),
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
                                  style: TextStyle(color: Color(0xffF5591F)),
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
                    )))));
  }

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    } else if (value.length < 3) {
      return 'Name must be more than 2 characters';
    } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return 'Name can only contain letters and spaces';
    } else if (!value.contains(RegExp(r'^[A-Z][a-z]+(\s[A-Z][a-z]+)*$'))) {
      return 'Name must be in the format: Firstname Lastname';
    }
    return null;
  }

  String? validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    } else if (!regex.hasMatch(value)) {
      return 'Enter Valid Email';
    }
    return null;
  }

  String? validateMobile(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Mobile number is required';
    } else if (value.length != 10) {
      return 'Mobile number must be of 10 digits';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'Mobile number can only contain numeric digits';
    } else if (!value.startsWith('0')) {
      return 'Mobile number must start with 0';
    }
    return null;
  }

  String? validatePassword(String? value) {
    //inputs & outputs nullable string value
    confirmPass = value;
    if (value!.isEmpty) {
      return "Please Enter New Password";
    } else if (value.length < 8) {
      return "Password must be atleast 8 characters long";
    } else {
      return null;
    }
  }

  String? confirmPassword(String? value) {
    if (value!.isEmpty) {
      return "Please Re-Enter New Password";
    } else if (value.length < 8) {
      return "Password must be atleast 8 characters long";
    } else if (value != confirmPass) {
      return "Password must be same as above";
    } else {
      return null;
    }
  }
}
class UserDetails{
  String fullName;
  String email;
  String monileNumber;
  String password;
  String role;
  UserDetails(this.fullName,this.email,this.monileNumber,this.password,this.role);
}