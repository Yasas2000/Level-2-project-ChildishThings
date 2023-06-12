import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/submition.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'app_bar.dart';
import 'configs.dart';
import 'homepage.dart';

//Stripes quotation

class stripsQuo extends StatefulWidget {
  const stripsQuo({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _stripQuoState createState() => _stripQuoState();
}

class _stripQuoState extends State<stripsQuo> {
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
  Widget build(BuildContext context) {
    return  Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: CustomAppBar(
              title: 'Stripes Quotation',
              leadingIcon: IconButton(
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
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("Asset/new.jpg"),
                    fit: BoxFit.cover,
                    opacity: 0.5
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                            'Please enter the below details. This will approximately take 2 minutes to complete. Our team will reach you within one working day with your customized quotation.'),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _firstNameController,
                          decoration: const InputDecoration(
                              icon: Icon(
                                Icons.person,
                                color: Colors.deepOrange,
                              ),
                              labelText: 'First Name*',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.deepOrange,
                                ),
                              ),
                              labelStyle: TextStyle(
                                color: Colors.deepOrange,
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
                              icon: Icon(
                                Icons.person,
                                color: Colors.deepOrange,
                              ),
                              labelText: 'Last Name*',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.deepOrange,
                                ),
                              ),
                              labelStyle: TextStyle(
                                color: Colors.deepOrange,
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
                              icon: Icon(
                                Icons.phone,
                                color: Colors.deepOrange,
                              ),
                              hintText: 'Ex:0777123456',
                              labelText: 'Contact Number*',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.deepOrange,
                                ),
                              ),
                              labelStyle: TextStyle(
                                color: Colors.deepOrange,
                                fontSize: 16,
                              )),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a valid phone number';
                            }
                            final phoneExp = RegExp(
                                r'^(?:0|\+94)(?:11|21|23|24|25|26|31|32|33|34|35|36|37|38|41|45|47|51|52|54|55|57|63|65|66|67|81|91|92|93|94|95|97|99|77|76|71|70|75|78)\d{7}$');
                            if (!phoneExp.hasMatch(value)) {
                              return 'Please enter a valid phone number';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                              icon: Icon(
                                Icons.email,
                                color: Colors.deepOrange,
                              ),
                              labelText: 'Email*',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.deepOrange,
                                ),
                              ),
                              labelStyle: TextStyle(
                                color: Colors.deepOrange,
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
                        readOnly: true,
                        controller: _dateController,
                        onTap: () async {
                          // Show the date picker when the field is tapped
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2100),
                          );

                          if (pickedDate != null) {
                            // Format the selected date as per your requirement
                            String formattedDate =
                            DateFormat('dd/MM/yyyy').format(pickedDate);

                            // Update the text field with the selected date
                            _dateController.text = formattedDate;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Event Date*',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.deepOrange,
                            ),
                          ),
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
                        },
                      ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            // Show the time picker when the field is tapped
                            showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            ).then((pickedTime) {
                              if (pickedTime != null) {
                                // Format the selected time as per your requirement
                                String formattedTime =
                                pickedTime.format(context);

                                // Update the text field with the selected time
                                _eventStarttimeController.text =
                                    formattedTime;
                              }
                            });
                          },
                          child: AbsorbPointer(
                            child: TextFormField(
                              controller: _eventStarttimeController,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^\d{1,2}:\d{2} [AP]M$')),
                              ],
                              decoration: InputDecoration(
                                labelText: 'Event Start Time*',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.deepOrange,
                                  ),
                                ),
                                hintText: 'Ex: 2:45 PM',
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
                                  return 'Please enter the event time';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _eventLocation,
                          decoration: const InputDecoration(
                              icon: Icon(
                                Icons.location_city,
                                color: Colors.deepOrange,
                              ),
                              labelText: 'Event location*',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.deepOrange,
                                ),
                              ),
                              labelStyle: TextStyle(
                                color: Colors.deepOrange,
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
                              icon: Icon(
                                Icons.event,
                                color: Colors.deepOrange,
                              ),
                              labelText:
                                  'Event Select*(eg;Birthday,corporate events,Parties,Wedding,Graduation,Other)',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.deepOrange,
                                ),
                              ),
                              labelStyle: TextStyle(
                                color: Colors.deepOrange,
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
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.person,
                              color: Colors.deepOrange,
                            ),
                            labelText: 'No.of Invitees *',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.deepOrange,
                              ),
                            ),
                            labelStyle: TextStyle(
                              color: Colors.deepOrange,
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
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.timelapse_rounded,
                              color: Colors.deepOrange,
                            ),
                            hintText: 'Ex:2',
                            labelText: 'Event duration in hours*',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.deepOrange,
                              ),
                            ),
                            labelStyle: TextStyle(
                              color: Colors.deepOrange,
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
                            if (!RegExp(r'^-?\d+$').hasMatch(value)) {
                              return 'Please enter a valid number';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          controller: _remarks,
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.person,
                              color: Colors.deepOrange,
                            ),
                            labelText: 'Remarks',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.deepOrange,
                              ),
                            ),
                            labelStyle: TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 16,
                            ),
                            helperText:
                                'Mention if you have any special concerns or requests',
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.deepOrange,
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final response = await http.post(
                                Uri.parse(localhost + '/api/Stripes'),
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
                                  'date': _dateController.text,
                                  'eventStarttime':
                                      _eventStarttimeController.text,
                                  'evenLocation': _eventLocation.text,
                                  'totInvitees': _totInvitees.text,
                                  'eventDurationHours':
                                      _eventDurationHours.text,
                                  'remarks': _remarks.text,
                                }),
                              );
                              if (response.statusCode == 200) {
                                var url = Uri.parse(localhost+'/send-email/quotationStripes');
                                var emailResponse = await http.post(url, body:{
                                  'firstName': _firstNameController.text,
                                  'lastName': _lastNameController.text,
                                  'contactNumber': _contactNumberController.text,
                                  'email': _emailController.text,
                                  'eventStarttime': _eventStarttimeController.text,
                                  'date': _dateController.text,
                                  'eventDurationHours': _eventDurationHours.text,
                                  'eventLocation': _eventLocation.text,
                                  'totInvitees': _totInvitees.text,
                                });
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
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
