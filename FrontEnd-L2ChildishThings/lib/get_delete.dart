// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/services/user_api_service.dart';
import 'package:frontend/models/user.dart';
class Admin extends StatefulWidget {

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  UserApiService apiService = UserApiService();
  late List<User> userList;

  

@override
  void initState() {
    super.initState();
    apiService.getAllUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
      ),
      body: FutureBuilder(
          future: apiService.getAllUser(),
          builder: (context, snapshot) {
            userList = snapshot.data ?? [];
            return ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (context, index){
                    User user = userList[index];
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        height: 140,
                        child: Card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                Text(user.id.toString()),
                                SizedBox(height: 10),
                                Text(user.firstName),
                                SizedBox(height: 10),
                                Text(user.lastName),
                                SizedBox(height: 10),
                                Text(user.email),
                                SizedBox(height: 10),
                                Text(user.phoneNumber),
                                ],                      
                             ),
                             IconButton( 
                              icon: Icon(FontAwesomeIcons.trash),
                              onPressed: () {
                                setState(() {
                                  apiService.deleteUser(user.id.toString());
                                });
                              },
                              ),
                            ],
                          ),
                        ),
                      ),                   
                    );
                  },
                );
              },
            ),
    );
  }
}