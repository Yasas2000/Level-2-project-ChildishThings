import 'package:flutter/foundation.dart';

class LoginState with ChangeNotifier{
  bool isLoggedIn=false;
  String id='null';
  String role='null';
  String username='Guest';
  void login(String userId, String userRole, String Username) {
    isLoggedIn = true;
    username=Username;
    id = userId;
    role = userRole;
    notifyListeners();
  }

  void logout() {
    isLoggedIn = false;
    id = 'null';
    role = 'null';
    username='Guest';
    notifyListeners();
  }


}