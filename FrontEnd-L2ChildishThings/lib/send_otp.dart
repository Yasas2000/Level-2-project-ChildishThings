// ignore_for_file: use_build_context_synchronously, camel_case_types

import 'package:flutter/material.dart';
import 'package:email_otp/email_otp.dart';
import 'package:frontend/otp_screen.dart';

class sendOTP extends StatefulWidget {
  const sendOTP({super.key});

  @override
  State<sendOTP> createState() => _sendOTPState();
}

class _sendOTPState extends State<sendOTP> {
  TextEditingController email = TextEditingController();
  EmailOTP myauth = EmailOTP();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              "https://img.freepik.com/free-vector/mail-sent-concept-illustration_114360-4657.jpg",
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
          Card(
            child: Column(
              children: [
                TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.mail,
                      color: Colors.orange,
                    ),
                    suffixIcon: IconButton(
                        onPressed: () async {
                          myauth.setConfig(
                              appEmail: "contact@hdevcoder.com",
                              appName: "Email OTP",
                              userEmail: email.text,
                              otpLength: 4,
                              otpType: OTPType.digitsOnly);
                          if (await myauth.sendOTP() == true) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("OTP has been sent"),
                            ));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OTPScreen(
                                          myauth: myauth,
                                        )));
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Oops, OTP send failed"),
                            ));
                          }
                        },
                        icon: const Icon(
                          Icons.send_rounded,
                          color: Colors.orange,
                        )),
                    hintText: "Email Address",
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
