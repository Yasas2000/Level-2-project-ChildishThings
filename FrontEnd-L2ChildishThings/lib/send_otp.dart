// ignore_for_file: use_build_context_synchronously, camel_case_types, slash_for_doc_comments

import 'package:flutter/material.dart';
import 'package:email_otp/email_otp.dart';
import 'package:frontend/otp_screen.dart';

import 'homepage.dart';

/**
 * This is the Email erification Screen
 */

class sendOTP extends StatefulWidget {
  const sendOTP({super.key});

  @override
  State<sendOTP> createState() => _sendOTPState();
}

class _sendOTPState extends State<sendOTP> {
  TextEditingController email = TextEditingController();
  EmailOTP myauth = EmailOTP();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: Colors.deepOrange,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: Text('Reset Password',style: TextStyle(color: Colors.deepOrange),),
        leading: IconButton(
          icon: Icon(
            Icons.home,
            color: Colors.deepOrange,
            size: 40,
          ),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage()),
                    (route)=>false
            );
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "Asset/sendOTP.jpg",
                  height: 350,
                ),
              ),
              const SizedBox(
                height: 60,
                child: Text(
                  "Enter your Email to get Code",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontFamily: 'Roboto',
                    letterSpacing: 1.5,
                    wordSpacing: 2,
                    shadows: [
                      Shadow(
                        blurRadius: 2,
                        color: Colors.grey,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                key: _formKey,
                child: Card(
                  child: Column(
                    children: [
                      TextFormField(
                          controller: email,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.mail,
                              color: Colors.deepOrange,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  myauth.setConfig(
                                    appEmail: "contact@hdevcoder.com",
                                    appName: "Email OTP",
                                    userEmail: email.text,
                                    otpLength: 4,
                                    otpType: OTPType.digitsOnly,
                                  );
                                  if (await myauth.sendOTP() == true) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("OTP has been sent"),
                                      ),
                                    );
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OTPScreen(
                                          myauth: myauth, emailController: email,
                                        ),
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
                              icon: const Icon(
                                Icons.send_rounded,
                                color: Colors.deepOrange,
                              ),
                            ),
                            hintText: "Email Address",
                            border: const OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(15.0)),
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter an email';
                            } else {
                              String pattern =
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,})$';
                              RegExp regex = RegExp(pattern);
                              if (!regex.hasMatch(value)) {
                                return 'Enter a valid email address';
                              }
                            }
                            return null;
                          }),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
