// ignore_for_file: unused_import, import_of_legacy_library_into_null_safe, prefer_interpolation_to_compose_strings, dead_code, avoid_print, prefer_const_declarations

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:frontend/models/user.dart';

String url = "http://localhost:5000/users/";

class UserApiService {
  Future<List<User>> fetchUsers() async {
    final jwtToken =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2M2Q5MWJiOTFiMmRhMTMxMDRiNWFlZWMiLCJyb2xlIjoiQWRtaW4iLCJpYXQiOjE2NzU0ODM3OTgsImV4cCI6MTY3NjA4ODU5OH0.S0PjmgMIm41q5wyIqzrQ4i9MFBOedt_4qZlmWglM26Y";
    final headers = {HttpHeaders.authorizationHeader: "Bearer $jwtToken"};
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<User?> findUserByEmail(String email) async {
    List<User> users = await fetchUsers();
    for (User user in users) {
        if (user.email == email) {
            return user;
        }
    }
    return null;
  }


  Future<User> updateUser(String id, Map<String, dynamic> data) async {
    final res = await http.put(Uri.parse(url + id), body: json.encode(data));

    if (res.statusCode == 200) {
      return User.fromJson(json.decode(res.body));
    } else {
      throw Exception('Fail to update users');
    }
  }
}
