import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:myproject/submition.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class stripsQuo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyForm(),
    );
  }
}

class MyForm extends StatefulWidget {
  const MyForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _contactNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _dateController = TextEditingController();
  final _eventStarttimeController = TextEditingController();
  final _eventSelect = TextEditingController();
  final _eventLocation = TextEditingController();
  final _totInvitees = TextEditingController();
  final _eventDurationHours = TextEditingController();
  final _remarks = TextEditingController();

  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("new.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.orange,
            actions: <Widget>[],
          ),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Strips Quotation',
                    style: TextStyle(
                      color: Color.fromARGB(255, 211, 77, 23),
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                      'Please enter the below details. This will approximately take 2 minutes to complete. Our team will reach you within one working day with your customized quotation.'),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _firstNameController,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        labelText: 'First Name*',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orange,
                          ),
                        ),
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 15, 14, 13),
                          fontSize: 16,
                        )),
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
                    decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        labelText: 'Last Name*',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orange,
                          ),
                        ),
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 15, 14, 13),
                          fontSize: 16,
                        )),
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
                    decoration: const InputDecoration(
                        icon: Icon(Icons.phone),
                        hintText: 'Ex:0777123456',
                        labelText: 'Contact Number*',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orange,
                          ),
                        ),
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 15, 14, 13),
                          fontSize: 16,
                        )),
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
                    decoration: const InputDecoration(
                        icon: Icon(Icons.email),
                        labelText: 'Email*',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orange,
                          ),
                        ),
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 15, 14, 13),
                          fontSize: 16,
                        )),
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
                    controller: _dateController,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.date_range),
                        labelText: 'Event date (MM/DD/YYYY)*',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orange,
                          ),
                        ),
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 15, 14, 13),
                          fontSize: 16,
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the event date';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _eventStarttimeController,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.lock_clock),
                        labelText: 'Event starting time*',
                        hintText: 'Hour/Min/Sec(AM/PM)',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orange,
                          ),
                        ),
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 15, 14, 13),
                          fontSize: 16,
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the event date';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _eventLocation,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.location_city),
                        labelText: 'Event location*',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orange,
                          ),
                        ),
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 15, 14, 13),
                          fontSize: 16,
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the location';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _eventSelect,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.event),
                        labelText:
                            'Event Select*(eg;Birthday,corporate events,Parties,Wedding,Graduation,Other)',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orange,
                          ),
                        ),
                        labelStyle: TextStyle(
                          color: Color.fromARGB(255, 15, 14, 13),
                          fontSize: 16,
                        ),
                        helperText:
                            'If the event is not in the list, please mention here'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a event';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _totInvitees,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'No.of Invitees *',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.orange,
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: Color.fromARGB(255, 15, 14, 13),
                        fontSize: 16,
                      ),
                      helperText:
                          'Number of Friends, Acquaintances and Colleagues',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the No.of Invitees';
                      }
                      if (!RegExp(r'^-?\d+$').hasMatch(value)) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _eventDurationHours,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.timelapse_rounded),
                      hintText: 'Ex:2',
                      labelText: 'Event duration in hours*',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.orange,
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: Color.fromARGB(255, 15, 14, 13),
                        fontSize: 16,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the event duration in hours';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _remarks,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'Remarks',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.orange,
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: Color.fromARGB(255, 15, 14, 13),
                        fontSize: 16,
                      ),
                      helperText:
                          'Mention if you have any special concerns or requests',
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final response = await http.post(
                          Uri.parse('http://localhost:3000/api/Strips'),
                          headers: <String, String>{
                            'Content-Type': 'application/json; charset=UTF-8',
                          },
                          body: jsonEncode(<String, dynamic>{
                            'firstName': _firstNameController.text,
                            'lastName': _lastNameController.text,
                            'contactNumber': _contactNumberController.text,
                            'email': _emailController.text,
                            'date': _dateController.text,
                            'eventStarttime': _eventStarttimeController.text,
                            'evenLocation': _eventLocation.text,
                            'totInvitees': _totInvitees.text,
                            'eventDurationHours': _eventDurationHours.text,
                            'remarks': _remarks.text,
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
                    child: Text('Submit'),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      );
}