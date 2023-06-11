// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, sized_box_for_whitespace

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_otp/email_otp.dart';
import 'package:frontend/forgotpassword.dart';
import 'package:frontend/signup_screen.dart';
import 'package:http/http.dart' as http;
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'app_bar.dart';
import 'configs.dart';
import 'homepage.dart';
import 'loginscreen.dart';


class Otp extends StatelessWidget {
  const Otp({
    Key? key,
    required this.otpController,
  }) : super(key: key);
  final TextEditingController otpController;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: TextFormField(
        controller: otpController,
        keyboardType: TextInputType.number,
        style: Theme.of(context).textTheme.titleLarge,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly
        ],
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
          if (value.isEmpty) {
            FocusScope.of(context).previousFocus();
          }
        },
        decoration: const InputDecoration(
          hintText: ('0'),
        ),
        onSaved: (value) {},
      ),
    );
  }
}

class SignUPOTPScreen extends StatefulWidget {
  final UserDetails user;
  const SignUPOTPScreen({Key? key, required this.myauth, required this.user}) : super(key: key);
  final EmailOTP myauth;
  @override
  State<SignUPOTPScreen> createState() => _SignUPOTPScreenState();
}

class _SignUPOTPScreenState extends State<SignUPOTPScreen> {
  TextEditingController otp1Controller = TextEditingController();
  TextEditingController otp2Controller = TextEditingController();
  TextEditingController otp3Controller = TextEditingController();
  TextEditingController otp4Controller = TextEditingController();

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
        barrierColor: Colors.deepOrange,
        text:
        "Congratulations,Your account has been successfully created.Please login",
        type: QuickAlertType.success,
        confirmBtnColor: Colors.green,
        onConfirmBtnTap: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()) ,
                (route) => false,
          );
        },
      );
    } else {
      QuickAlert.show(
        context: context,
        barrierColor: Colors.deepOrange,
        text:"The Email Already Existed",
        type: QuickAlertType.error,
        confirmBtnColor: Colors.red,
        onConfirmBtnTap: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()) ,
                (route) => false,
          );
        },
      );
      throw Exception("Fail to sign up user");
    }
  }

  String otpController = "1234";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: 'OTP Request',
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
        backgroundColor: Colors.white,
        body: Center(
            child: SingleChildScrollView(
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
                      angle: 38,
                      child: Image(
                        image: AssetImage('Asset/email.png'),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  Text(
                    "Verification",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Please enter the 4 digit code sent",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade500,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Otp(
                        otpController: otp1Controller,
                      ),
                      Otp(
                        otpController: otp2Controller,
                      ),
                      Otp(
                        otpController: otp3Controller,
                      ),
                      Otp(
                        otpController: otp4Controller,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (await widget.myauth.verifyOTP(
                          otp: otp1Controller.text +
                              otp2Controller.text +
                              otp3Controller.text +
                              otp4Controller.text) ==
                          true) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("OTP is verified"),
                        ));
                        userSignUp(
                            widget.user.fullName,
                            widget.user.email,
                            widget.user.monileNumber,
                            widget.user.password,
                            widget.user.role
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Invalid OTP"),
                        ));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.deepOrange, // text color
                      elevation: 5, // button elevation
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ), // rounded corner
                    ),
                    child: Container(
                      width: double.maxFinite, // button width match parent
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: const Text(
                        "Confirm",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )));
  }
}
