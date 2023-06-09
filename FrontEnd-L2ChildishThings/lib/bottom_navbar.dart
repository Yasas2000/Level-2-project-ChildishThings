import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/homepage.dart';
import 'package:frontend/loginscreen.dart';
import 'package:frontend/request_form.dart';
import 'package:provider/provider.dart';

import 'donation_form.dart';
import 'login_state.dart';

class BottomNavbar extends StatefulWidget {

  const BottomNavbar({Key? key}) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  late int _appBarSelectedIndex=0;
  void _onAppBarTapped(int index) {
    setState(() {
      _appBarSelectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    final loginState=Provider.of<LoginState>(context);
    return BottomNavigationBar(
      backgroundColor: Colors.deepOrange,
      items: [
        BottomNavigationBarItem(
          backgroundColor: Colors.deepOrange,
          icon: IconButton(
            icon: Icon(Icons.home, color: Colors.white,),
            onPressed: (){
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) =>
                      HomePage()
                  ));
            }

          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.deepOrange,
          icon: IconButton(
            icon: Icon(Icons.handshake, color: Colors.white,),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) =>
                      DonationForm()
                  ));
            },
          ),
          label: 'Donation',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.deepOrange,
          icon: IconButton(
            icon: Icon(Icons.request_page, color: Colors.white,),
            onPressed: ()  {
              if(loginState.role!='null'){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) =>
                        RequestingForm()
                    ));
              }else{
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) =>
                        LoginScreen()
                    ));
              }
            },
          ),
          label: 'RequestMoney',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.deepOrange,
          icon: IconButton(
            icon: Icon(Icons.dashboard, color: Colors.white,),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) =>
                      RequestingForm()
                  ));
            },
          ),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.deepOrange,
          icon: IconButton(
            icon: Icon(Icons.photo_camera, color: Colors.white,),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) =>
                      HomePage()
                  ));
            },
          ),
          label: 'PhotoBoothMe',
        ),
      ],
      currentIndex:_appBarSelectedIndex,
      showUnselectedLabels: true,


      selectedItemColor: Colors.white,
      onTap: _onAppBarTapped,);
  }
}



