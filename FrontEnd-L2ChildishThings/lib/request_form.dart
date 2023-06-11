import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/bottom_navbar.dart';
import 'package:frontend/eduHelp_form.dart';
import 'package:frontend/financialReq_form.dart';
import 'package:provider/provider.dart';

import 'app_bar.dart';
import 'donee_details.dart';
import 'homepage.dart';
import 'login_state.dart';

class RequestingForm extends StatefulWidget {
  const RequestingForm({Key? key}) : super(key: key);

  @override
  _RequestingFormState createState() => _RequestingFormState();
}

class _RequestingFormState extends State<RequestingForm> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _telephoneNumber;
  late String _email;
  late String _category = 'Select';

  @override
  Widget build(BuildContext context) {
    final loginState=Provider.of<LoginState>(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Request Help',
        leadingIcon:  IconButton(
          icon: Icon(Icons.home,color: Colors.deepOrange,size: 40,),
          onPressed:(){
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage()),
                    (route)=>false
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavbar(initialIndex: 2,),
      body: Column(
        children: [
          Container(
            height: 300,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
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
                image: AssetImage('assets/r1.jpg'),
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
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
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
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Full Name',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _name = value!;
                            },
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
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
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Telephone Number',
                            ),
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
                            onSaved: (value) {
                              _telephoneNumber = value!;
                            },
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
                                decoration: const InputDecoration(
                                  labelText: 'Email',
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
                                onSaved: (value){
                                  _email = value!;
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
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
                          child: DropdownButtonFormField(
                            value: _category,
                            decoration: const InputDecoration(
                              labelText: 'Category',
                            ),
                            items: ['Select', 'Educational', 'Financial']
                                .map((label) =>
                                DropdownMenuItem(
                                  value: label,
                                  child: Text(label),
                                ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _category = value!;
                              });
                            },
                            validator: (value) {
                              if (value == 'Select') {
                                return 'Please select a category';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 24),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrange,
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                Donee donee=Donee(_name,_telephoneNumber,_category,_email,loginState.id);
                                if(_category=='Educational'){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EducationalHelpRequestingForm(donee:donee ,)),
                                  );
                                }else{
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FinancialRequestingForm(donee: donee,)),
                                  );
                                }
                              }
                            },
                            child: const Text('Request'),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
          )
        ],
      ),
    );
  }
}