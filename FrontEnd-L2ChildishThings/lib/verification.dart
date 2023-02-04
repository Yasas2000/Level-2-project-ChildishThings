// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, unnecessary_new, prefer_final_fields, unused_field, non_constant_identifier_names, prefer_interpolation_to_compose_strings, sized_box_for_whitespace, unused_import, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:email_auth/email_auth.dart';
import 'package:frontend/signup_screen.dart';


class Verification extends StatefulWidget {
  const Verification({Key? key}): super(key: key);

  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {

  bool _isResendAgain = false;
  bool _isVerified = false;
  bool _isLoading = false;
  TextEditingController _otpController = TextEditingController();

  String _code = '';
  late Timer _timer;
  int _start = 60;

  void Resend(){
    setState(() {
      _isResendAgain = true;
    });

    const oneSec = Duration(seconds: 1);
    _timer = new Timer.periodic(oneSec, (timer) {
      setState(() {
        if(_start == 0){
          _start = 60;
          _isResendAgain = false;
          timer.cancel();
        }
        else{
          _start--;
        }
      });
     });
  }

  verify(){
    setState(() {
      _isLoading = true;
    });

     const oneSec = Duration(milliseconds: 10000);
    _timer = new Timer.periodic(oneSec, (timer) {
      setState(() {
        _isLoading = false;
        _isVerified = true;
      });
     });
  }

  void verifyOTP() async{
   // var res = EmailAuth.validate(receiverMail: , userOTP: _code);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
       body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 200,
                height: 200,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade200
                ),
                child: Transform.rotate(
                  angle: 38,
                  child: Image(
                    image: AssetImage('assets/email.png'), 
                    ),
                  ),
              ),
              SizedBox(height: 80,),
              Text("Verification",style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              ),
              SizedBox(height: 30,),
              Text("Please enter 6 digit code sent to \n janith@gmail.com",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16,color: Colors.grey.shade500,height: 1.5),
                ),
              SizedBox(height: 30,),
              VerificationCode(
                length: 6,
                textStyle: TextStyle(fontSize: 20),
                underlineColor: Colors.blueAccent,
                keyboardType: TextInputType.number,
                onCompleted: (value) {
                  setState(() {
                    _code = value;
                  });
                },
                onEditing: (value) {}
               ),
               SizedBox(height: 20,),
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Didn't receive code? ",style: TextStyle(fontSize: 14,color: Colors.grey.shade500),),
                  TextButton(
                    onPressed: () {
                      if(_isResendAgain) return;

                      Resend();
                    }, 
                    child: Text(_isResendAgain ? "Try again in " + _start.toString() : "Resend",style: TextStyle(color: Colors.blueAccent),)
                    )
                ],
               ),
               SizedBox(height: 50,),
               MaterialButton(
                disabledColor: Colors.grey.shade300,
                onPressed: _code.length < 6 ? null: () {verify();},
                color: Colors.black,
                minWidth: double.infinity,
                height: 50,
                child: _isLoading ? Container(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    strokeWidth: 3,
                    color: Colors.black,
                  ),
                ) : 
                _isVerified ? Icon(Icons.check_circle,color:  Colors.white,size: 30,) : Text("Verify and Create Account",style: TextStyle(color: Colors.white),),
                )
            ],
          ),
        ) 
        ) 
    );
  }
}