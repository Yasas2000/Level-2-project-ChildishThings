// ignore_for_file: unused_import, use_key_in_widget_constructors, prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables, avoid_print, library_private_types_in_public_api, override_on_non_overriding_member

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_auth/email_auth.dart';
import 'package:frontend/verification.dart';

class SignUpScreen extends StatefulWidget {

  @override
  _SignUpScreenState createState() =>  _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  @override

  Widget buildCreateAccBtn(){
      return Container(
          padding: EdgeInsets.symmetric(vertical: 25),
          width: double.infinity,
          child: ElevatedButton(
                  onPressed: ()  {
                   Navigator.push(context, MaterialPageRoute(
                   builder: (context) => Verification()));
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
                                      Container(
                                        margin: EdgeInsets.only(left: 20,right: 20,top: 40),
                                        padding: EdgeInsets.only(left: 20,right: 20),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
                                          color: Colors.grey[200],
                                          boxShadow: [BoxShadow(
                                            offset: Offset(0,10),
                                            blurRadius: 30,
                                            color: Color(0xB3EEEEEE)
                                          )],
                                        ),
                                        alignment: Alignment.center,
                                        child: TextField(
                                          cursorColor: Color(0xcc0048ba),
                                          decoration: InputDecoration(
                                            icon: Icon(
                                              Icons.person,
                                              color: Color(0xff0048ba),
                                            ),
                                            hintText: "Full Name",
                                            enabledBorder: InputBorder.none,
                                            focusedBorder: InputBorder.none
                                          ),
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
                                        child: TextField(
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
                                        child: TextField(
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
                                        child: TextField(
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
                                        child: TextField(
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
                ),
            ),
        );
    }
}
  


