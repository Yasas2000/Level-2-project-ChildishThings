import 'package:flutter/material.dart';
import 'package:frontend/type.dart';
import 'app_bar.dart';
import 'homepage.dart';

//Selecting whether the user is an admin or a customer

class AdminForm extends StatefulWidget {
  @override
  _AdminFormState createState() => _AdminFormState();
}

class _AdminFormState extends State<AdminForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isAdmin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: 'Selection Form',leadingIcon:IconButton(
          icon: Icon(Icons.home),
          iconSize: 40,
          color: Colors.deepOrange,
          onPressed:(){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                HomePage()
            ));
          },
        )),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("new.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Image.asset(
                    'logo.png',
                    width: 200,
                    height: 200,
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Are you an admin?',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.orange,
                          ),
                        ),
                        SizedBox(height: 10),
                        DropdownButtonFormField<bool>(
                          value: _isAdmin,
                          items: [
                            DropdownMenuItem(
                              value: true,
                              child: Text('Yes'),
                            ),
                            DropdownMenuItem(
                              value: false,
                              child: Text('No'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _isAdmin = value!;
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                print('Admin status: $_isAdmin');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Material(
                                      child: type(),
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.orange,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
