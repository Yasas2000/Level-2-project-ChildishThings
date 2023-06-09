
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/submition.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'app_bar.dart';
import 'configs.dart';

//Portrait quotation

class poratraitQuo extends StatefulWidget {
  const poratraitQuo({super.key});

  Future<void> portraitQuotationForm() async {}

  @override
  _poratraitQuoState createState() => _poratraitQuoState();
}

class _poratraitQuoState extends State<poratraitQuo> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _contactNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _eventStarttimeController = TextEditingController();
  final _dateController = TextEditingController();
  final _eventDurationHours = TextEditingController();
  final _eventLocation = TextEditingController();
  final _totInvitees = TextEditingController();
  final _numBigFamilies = TextEditingController();
  final _numSmallFamilies = TextEditingController();
  final _numMarriedCouples = TextEditingController();
  final _numUnMarriedCouples = TextEditingController();
  final _numIndividualInvitees = TextEditingController();
  final _remarks = TextEditingController();

  Future<void> sendEmail(
      String firstName,
      String lastName,
      String contactNumber,
      String email,
      String eventStarttime,
      String date,
      String eventDurationHours,
      String evenLocation,
      String totInvitees,
      String numBigFamilitLoces,
      String numSmallFamilies,
      String numMarriedCouples,
      String numUnMarriedCouples,
      String numIndividualInvitees,
      String remarks) async {
    final serviceId = 'service_x3msbcj';
    final templateId = 'template_t4ksedq';
    final userId = 'user_Jupr8bR5djA4tpKNS';
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(url,
        headers: {
          'Connect-Type': 'application/json',
        },
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': userId,
          'template_params': {
            'user_fname': firstName,
            'user_lname': lastName,
            'user_contactNum': contactNumber,
            'user_email': email,
            'date': date,
            'eventDurationHours': eventDurationHours,
            'evenLocation': evenLocation,
            'totInvitees': totInvitees,
            'numBigFamilitLoces': numBigFamilitLoces,
            'numSmallFamilies': numSmallFamilies,
            'numMarriedCouples': numMarriedCouples,
            'numUnMarriedCouples': numUnMarriedCouples,
            'numIndividualInvitees': numIndividualInvitees,
            'remarks': remarks,
          }
        }));

    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: CustomAppBar(
              title: 'Portrait Quotation',
              leadingIcon:  IconButton(
                icon: Icon(Icons.arrow_back_ios_outlined,color: Colors.deepOrange,size: 40,),
                onPressed:(){
                  Navigator.of(context).pop();
                },
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("Asset/new.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: Align(
                    alignment: Alignment.center,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 20),
                          const Text(
                              'Please enter the below details. This will approximately take 2 minutes to complete. Our team will reach you within one working day with your customized quotation.',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              )),
                          const SizedBox(height: 20),
                          SizedBox(height: 50),
                          TextFormField(
                            controller: _firstNameController,
                            decoration: InputDecoration(
                              labelText: 'First Name*',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.deepOrange,
                                ),
                              ),
                              icon: Icon(
                                Icons.person,
                                color: Colors.deepOrange,
                              ),
                              labelStyle: TextStyle(
                                color: Colors.deepOrange,
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the first name';
                              }
                              if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                                return 'Please enter a valid name (only alphabets)';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _lastNameController,
                            decoration: InputDecoration(
                              labelText: 'Last Name*',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.deepOrange,
                                ),
                              ),
                              icon: Icon(
                                Icons.person,
                                color: Colors.deepOrange,
                              ),
                              labelStyle: TextStyle(
                                color: Colors.deepOrange,
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the last name';
                              }
                              if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                                return 'Please enter a valid name (only alphabets)';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _contactNumberController,
                            decoration: InputDecoration(
                              labelText: 'Contact Number*',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.deepOrange,
                                ),
                              ),
                              hintText: 'Ex : 0777123456',
                              icon: Icon(
                                Icons.phone,
                                color: Colors.deepOrange,
                              ),
                              labelStyle: TextStyle(
                                color: Colors.deepOrange,
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a contact number';
                              }
                              if (!RegExp(
                                      r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
                                  .hasMatch(value)) {
                                return 'Please enter a valid contact number';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Email*',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.orange,
                                ),
                              ),
                              icon: Icon(
                                Icons.email,
                                color: Colors.deepOrange,
                              ),
                              labelStyle: TextStyle(
                                color: Colors.deepOrange,
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter an email address';
                              }
                              if (!RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _eventStarttimeController,
                            decoration: InputDecoration(
                              labelText: 'Event Start Time*',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.deepOrange,
                                ),
                              ),
                              hintText: 'Ex:2.45 PM',
                              icon: Icon(
                                Icons.lock_clock,
                                color: Colors.deepOrange,
                              ),
                              labelStyle: TextStyle(
                                color: Colors.deepOrange,
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the event date';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                              controller: _dateController,
                              decoration: InputDecoration(
                                labelText: 'Event Date*',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.deepOrange,
                                  ),
                                ),
                                hintText: 'DD/MM/YYYY',
                                icon: Icon(
                                  Icons.date_range,
                                  color: Colors.deepOrange,
                                ),
                                labelStyle: TextStyle(
                                  color: Colors.deepOrange,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter the event date';
                                }
                                return null;
                              }),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _eventDurationHours,
                            decoration: InputDecoration(
                              labelText: 'Event Duration in Hours*',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.deepOrange,
                                ),
                              ),
                              hintText: 'Ex:2',
                              icon: Icon(
                                Icons.lock_clock,
                                color: Colors.deepOrange,
                              ),
                              labelStyle: TextStyle(
                                color: Colors.deepOrange,
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter a valid number';
                              }
                              if (double.tryParse(value) == null) {
                                return 'Please enter a number';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _eventLocation,
                            decoration: InputDecoration(
                              labelText: 'Event Location*',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.deepOrange,
                                ),
                              ),
                              hintText: 'Ex:Moratuwa',
                              icon: Icon(
                                Icons.place,
                                color: Colors.deepOrange,
                              ),
                              labelStyle: TextStyle(
                                color: Colors.deepOrange,
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the location';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Information about guests',
                            style: TextStyle(
                              color: Color.fromARGB(255, 211, 77, 23),
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: 20),
                          Text(
                            'We collect these information to calculate the exact price value for your event.',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _totInvitees,
                            decoration: InputDecoration(
                              labelText: 'Total Invitees *',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.deepOrange,
                                ),
                              ),
                              helperText:
                                  'Number of invitees expected for the event',
                              icon: Icon(
                                Icons.person,
                                color: Colors.deepOrange,
                              ),
                              labelStyle: TextStyle(
                                color: Colors.deepOrange,
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the total invitees ';
                              }
                              if (!RegExp(r'^-?\d+$').hasMatch(value)) {
                                return 'Please enter a valid number';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _numBigFamilies,
                            decoration: InputDecoration(
                              labelText: 'Number of Big Families*',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.deepOrange,
                                ),
                              ),
                              helperText:
                                  'Number of families with more than 04 members (>4)',
                              icon: Icon(
                                Icons.person,
                                color: Colors.deepOrange,
                              ),
                              labelStyle: TextStyle(
                                color: Colors.deepOrange,
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the number of big families ';
                              }
                              if (!RegExp(r'^-?\d+$').hasMatch(value)) {
                                return 'Please enter a valid number';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _numSmallFamilies,
                            decoration: InputDecoration(
                              labelText: 'Number of Small Families*',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.deepOrange,
                                ),
                              ),
                              helperText:
                                  'Number of families with 04 or less than 04 members (<=4)',
                              icon: Icon(
                                Icons.person,
                                color: Colors.deepOrange,
                              ),
                              labelStyle: TextStyle(
                                color: Colors.deepOrange,
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the number of small families ';
                              }
                              if (!RegExp(r'^-?\d+$').hasMatch(value)) {
                                return 'Please enter a valid number';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _numMarriedCouples,
                            decoration: InputDecoration(
                              labelText: 'Number of Married Couples*',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.deepOrange,
                                ),
                              ),
                              helperText: 'Number of married couples',
                              icon: Icon(
                                Icons.person,
                                color: Colors.deepOrange,
                              ),
                              labelStyle: TextStyle(
                                color: Colors.deepOrange,
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the number of married couples ';
                              }
                              if (!RegExp(r'^-?\d+$').hasMatch(value)) {
                                return 'Please enter a valid number';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _numUnMarriedCouples,
                            decoration: const InputDecoration(
                              labelText: 'Number of Unmarried Couples*',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.deepOrange,
                                ),
                              ),
                              helperText: 'Number of unmarried couples',
                              icon: Icon(
                                Icons.abc,
                                color: Colors.deepOrange,
                              ),
                              labelStyle: TextStyle(
                                color: Colors.deepOrange,
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the number of unmarried couples ';
                              }
                              if (!RegExp(r'^-?\d+$').hasMatch(value)) {
                                return 'Please enter a valid number';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _numIndividualInvitees,
                            decoration: InputDecoration(
                              labelText: 'Number of Individual Invitees*',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.deepOrange,
                                ),
                              ),
                              helperText:
                                  'Number of Friends, Acquaintances and Colleagues',
                              icon: Icon(
                                Icons.person,
                                color: Colors.deepOrange,
                              ),
                              labelStyle: TextStyle(
                                color: Colors.deepOrange,
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter the number of indiviual invitees ';
                              }
                              if (!RegExp(r'^-?\d+$').hasMatch(value)) {
                                return 'Please enter a valid number';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _remarks,
                            decoration: InputDecoration(
                              labelText: 'Remarks',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.deepOrange,
                                ),
                              ),
                              helperText:
                                  'Mention if you have any special concerns or requests',
                              icon: Icon(
                                Icons.note,
                                color: Colors.deepOrange,
                              ),
                              labelStyle: TextStyle(
                                color: Colors.deepOrange,
                              ),
                            ),
                          ),
                          SizedBox(height: 40),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.deepOrange,
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final response = await http.post(
                                  Uri.parse(localhost + '/api/post'),
                                  headers: <String, String>{
                                    'Content-Type':
                                        'application/json; charset=UTF-8',
                                  },
                                  body: jsonEncode(<String, dynamic>{
                                    'firstName': _firstNameController.text,
                                    'lastName': _lastNameController.text,
                                    'contactNumber':
                                        _contactNumberController.text,
                                    'email': _emailController.text,
                                    'eventStarttime':
                                        _eventStarttimeController.text,
                                    'date': _dateController.text,
                                    'eventDurationHours':
                                        _eventDurationHours.text,
                                    'evenLocation': _eventLocation.text,
                                    'totInvitees': _totInvitees.text,
                                    'numBigFamilitLoces': _numBigFamilies.text,
                                    'numSmallFamilies': _numSmallFamilies.text,
                                    'numMarriedCouples':
                                        _numMarriedCouples.text,
                                    'numUnMarriedCouples':
                                        _numUnMarriedCouples.text,
                                    'numIndividualInvitees':
                                        _numIndividualInvitees.text,
                                    'remarks': _remarks.text,
                                  }),
                                );
                                if (response.statusCode == 200) {
                                  var url = Uri.parse(localhost+'/send-email/quotation');
                                  var emailResponse = await http.post(url, body: jsonEncode(<String, dynamic>{
                                    'firstName': _firstNameController.text,
                                    'lastName': _lastNameController.text,
                                    'contactNumber': _contactNumberController.text,
                                    'email': _emailController.text,
                                    'eventStarttime': _eventStarttimeController.text,
                                    'date': _dateController.text,
                                    'eventDurationHours': _eventDurationHours.text,
                                    'evenLocation': _eventLocation.text,
                                    'totInvitees': _totInvitees.text,
                                    'numBigFamilitLoces': _numBigFamilies.text,
                                    'numSmallFamilies': _numSmallFamilies.text,
                                    'numMarriedCouples': _numMarriedCouples.text,
                                    'numUnMarriedCouples': _numUnMarriedCouples.text,
                                    'numIndividualInvitees': _numIndividualInvitees.text,
                                  }),);
                                  if (emailResponse.statusCode == 200) {
                                    print('Email sent successfully!');
                                  } else {
                                    print('Failed to send email. Error code: ${emailResponse.statusCode}');
                                  }
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => submition()),
                                  );
                                }
                              }
                            },
                            child: Text('Submit'),
                          ),
                          SizedBox(height: 80),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }
}
