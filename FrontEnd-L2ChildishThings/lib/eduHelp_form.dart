import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/submition.dart';
import 'package:http/http.dart' as http;

import 'app_bar.dart';
import 'configs.dart';
import 'donee_details.dart';

class EducationalHelpRequestingForm extends StatefulWidget {
  final Donee donee;
  const EducationalHelpRequestingForm({Key? key, required this.donee}) : super(key: key);

  @override
  _EducationalHelpRequestingFormState createState() => _EducationalHelpRequestingFormState();
}

class _EducationalHelpRequestingFormState extends State<EducationalHelpRequestingForm>{
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _purposeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telephoneNumberController = TextEditingController();

  void _clearForm(){
    _purposeController.clear();
    _nameController.clear();
    _addressController.clear();
    _emailController.clear();
    _telephoneNumberController.clear();
  }

  late String _purpose;
  late String _instituteName;
  late String _instituteAddress;
  late String _instituteEmail;
  late String _telephoneNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Educational Request',
        leadingIcon:  IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined,color: Colors.deepOrange,size: 40,),
          onPressed:(){
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 200,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
              image: DecorationImage(
                image: AssetImage('assets/e1.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: const [
                Positioned(
                  bottom: 5,
                  right: 10,
                  child: Text(
                    'Powered by ChildishThings',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children:[
                            TextFormField(
                              controller: _purposeController,
                              decoration: const InputDecoration(
                                labelText: 'Purpose',
                              ),
                              validator: (value){
                                if (value!.isEmpty){
                                  return 'Please enter your purpose';
                                }
                                return null;
                              },
                              onSaved: (value){
                                _purpose = value!;
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children:[
                            TextFormField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                labelText: 'Institute Name',
                              ),
                              validator: (value){
                                if (value!.isEmpty){
                                  return 'Please enter your Institute name';
                                }
                                return null;
                              },
                              onSaved: (value){
                                _instituteName = value!;
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow:[
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children:[
                            TextFormField(
                              controller: _addressController,
                              decoration: const InputDecoration(
                                labelText: 'Institute Address',
                              ),
                              validator: (value){
                                if (value!.isEmpty){
                                  return 'Please enter your Institute address';
                                }
                                return null;
                              },
                              onSaved: (value){
                                _instituteAddress = value!;
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children:[
                            TextFormField(
                              controller: _emailController,
                              decoration: const InputDecoration(
                                labelText: 'Institute Email',
                              ),
                              validator: (value){
                                if (value!.isEmpty){
                                  return 'Please enter your Institute email';
                                }
                                if (!value.contains('@')|| !value.contains('.')){
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                              onSaved: (value){
                                _instituteEmail = value!;
                              },
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()){
                              _formKey.currentState!.save();
                              final response = await http.post(
                                Uri.parse(localhost + '/edurequest'),
                                headers: <String, String>{
                                  'Content-Type':
                                  'application/json; charset=UTF-8',
                                },
                                body: jsonEncode(<String, dynamic>{
                                  'userId':widget.donee.userId,
                                  'fullName': widget.donee.name,
                                  'telephoneNumber': widget.donee.number,
                                  'email': widget.donee.email,
                                  'purpose':_purpose,
                                  'instituteName':_instituteName,
                                  'instituteAddress':_instituteAddress,
                                  'instituteEmail':_instituteEmail
                                }),
                              );
                              if (response.statusCode == 200) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => submition()),
                                );
                              }
                            }
                          },
                          child: const Text('Request'),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                          ),
                          onPressed: (){
                            _clearForm();
                          },
                          child: const Text('Clear All'),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submitForm(){

  }
}
