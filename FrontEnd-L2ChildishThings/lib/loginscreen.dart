// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, avoid_print, sized_box_for_whitespace, unused_field, unnecessary_new, unused_element, curly_braces_in_flow_control_structures, unused_import, non_constant_identifier_names, prefer_typing_uninitialized_variables, unused_local_variable, import_of_legacy_library_into_null_safe, use_build_context_synchronously, avoid_unnecessary_containers

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/forgotpassword.dart';
import 'package:frontend/home.dart';
import 'package:frontend/login_state.dart';
import 'package:frontend/send_otp.dart';
import 'package:frontend/signup_screen.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:http/http.dart' as http;
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:quickalert/quickalert.dart';
import 'package:url_launcher/url_launcher.dart';

import 'app_bar.dart';
import 'configs.dart';
import 'homepage.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) :super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  void initState() {
    _loadUserEmailPassword();
    super.initState();
  }
  bool isRememberMe = false;
  bool _isLoading = false;
  bool _obscureText = true;
  bool _isChecked=false;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  SignIn(String email, String pass) async {
    final loginState=Provider.of<LoginState>(context,listen: false);
    String url = localhost_+"/users/authenticate";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    Map body = {"email": email, "password": pass};

    var jsonResponse;
    var res = await http.post(Uri.parse(url), body: body);
    //Need to check api status
    if (res.statusCode == 200) {
      jsonResponse = json.decode(res.body);
      String username=jsonResponse['user']['fullName'];
      String id=jsonResponse['user']['email'];
      String role=jsonResponse['user']['role'];
      loginState.login(id, role, username);

      print("Response status: ${res.statusCode}");

      print("Response status: ${res.body}");

      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        if (jsonResponse != null && jsonResponse['token'] != null) {
          sharedPreferences.setString("token", jsonResponse['token']);
        }

        if (jsonResponse['user']['role'] == "Admin") {
          showAlert(QuickAlertType.success, "Admin");
        } else if (jsonResponse['user']['role'] == "User") {
          showAlert(QuickAlertType.success, "User");
        } else {
          showAlert(QuickAlertType.error, "");
        }
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void showAlert(QuickAlertType quickAlertType, String role) {
    QuickAlert.show(
        context: context,
        text: "You have successfully logged in",

        type:quickAlertType,
        confirmBtnColor: Colors.green,
        onConfirmBtnTap: () {
          if (role == "Admin") {
            Dialogs.bottomMaterialDialog(
                msg: 'Which page would you like to navigate to?',
                title: 'Hi! Admin',
                context: context,
                actions: [
                  IconsOutlineButton(
                    onPressed: () {
                    _launchURL('https://pub.dev/');
                    },
                    text: 'Dashboard',
                    iconData: Icons.dashboard_customize_rounded,
                    color: Colors.deepOrange,
                    textStyle: TextStyle(color: Colors.white),
                    iconColor: Colors.white,
                  ),
                  IconsButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (BuildContext context) => HomePage()),
                          (Route<dynamic> route) => false);
                    },
                    text: 'Home',
                    iconData: Icons.home_filled,
                    color: Colors.deepOrange,
                    textStyle: TextStyle(color: Colors.white),
                    iconColor: Colors.white,
                  ),
                ]);
          } else if (role == "User") {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (BuildContext context) => HomePage()),
                (Route<dynamic> route) => false);
          } else {
            Navigator.pop(context);
          }
        });
  }

  void _handleRemeberme(bool value) {
    _isChecked = value;
    SharedPreferences.getInstance().then(
          (prefs) {
        prefs.setBool("remember_me", value);
        prefs.setString('email', emailController.text);
        prefs.setString('password', passwordController.text);
      },
    );
    setState(() {
      _isChecked = value;
    });
  }
  void _loadUserEmailPassword() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _email = _prefs.getString("email") ?? "";
      var _password = _prefs.getString("password") ?? "";
      var _remeberMe = _prefs.getBool("remember_me") ?? false;
      print(_remeberMe);
      print(_email);
      print(_password);
      if (_remeberMe) {
        setState(() {
          _isChecked = true;
        });
        emailController.text = _email ?? "";
        passwordController.text = _password ?? "";
      }
    } catch (e)
    {
      print(e);
    }
  }

  Widget buildRememberCb() {
    return Container(
      height: 40,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.grey),
            child: Checkbox(
              value: _isChecked,
              activeColor: Colors.orange,
              checkColor: Colors.white,
              onChanged: (value) {
                _handleRemeberme(value??false);
                //widget.prefs.setBool('rememberMe', value??false);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
                side: BorderSide(color: Colors.grey),
              ),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
          SizedBox(width: 5),
          Text(
            'Remember me',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loginState=Provider.of<LoginState>(context);
    return Scaffold(
        appBar:  CustomAppBar(title: '',leadingIcon:IconButton(
          icon: Icon(Icons.home),
          iconSize: 40,
          color: Colors.deepOrange,
          onPressed:(){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                HomePage()
            ));
          },
        )),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Form(
                autovalidateMode: AutovalidateMode.always,
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    Container(
                      height: 320,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(90)),
                        color: Color(0xffF5591F),
                        gradient: LinearGradient(
                          colors: [Color(0xffF5591F), Color(0xffF2861E)],
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
                              margin: EdgeInsets.only(top: 10),
                              child: Image.asset(
                                "Asset/Photobooth.png",
                                height: 200,
                                width: 200,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 20, top: 20),
                              alignment: Alignment.bottomRight,
                              child: Text(
                                "Hello there!",
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
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 20, right: 20, top: 70),
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
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Color(0xffF5591F),
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.email,
                            color: Color(0xffF5591F),
                          ),
                          hintText: "Enter Email",
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        validator: MultiValidator([
                          RequiredValidator(errorText: "* Required"),
                          EmailValidator(errorText: "Enter valid email id"),
                        ]),
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
                            controller: passwordController,
                            obscureText: _obscureText,
                            keyboardType: TextInputType.text,
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
                            validator: MultiValidator([
                              RequiredValidator(errorText: "* Required"),
                              MinLengthValidator(6,
                                  errorText:
                                      "Password should be at least 6 characters"),
                              MaxLengthValidator(15,
                                  errorText:
                                      "Password should not be greater than 15 characters"),
                            ]),
                            
                          ),
                          Positioned(
                            right: 20,
                            bottom: 25,
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => _obscureText = !_obscureText),
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
                    SizedBox(
                      height: 10,
                    ),
                    buildRememberCb(),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => sendOTP()),
                          );
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        SignIn(emailController.text, passwordController.text);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
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
                          "LOGIN",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't Have Any Account?  "),
                          GestureDetector(
                            child: Text(
                              "Register Now",
                              style: TextStyle(color: Color(0xffF5591F)),
                            ),
                            onTap: () {
                              // Write Tap Code Here.
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUpScreen(),
                                  ));
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                )))));
  }

  String validatePassword(String value) {
    if (value.isEmpty) {
      return "* Required";
    } else if (value.length < 6) {
      return "Password should be atleast 6 characters";
    } else if (value.length > 15) {
      return "Password should not be greater than 15 characters";
    } else
      return '';
  }

  Future<void> _launchURL(String url) async {
    
    final Uri uri = Uri(scheme: "https", host: url);
    if(!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
      )){
        throw "Can not launch url";
      }
  } 

}
