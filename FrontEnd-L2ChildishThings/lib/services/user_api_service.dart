// ignore_for_file: unused_import, import_of_legacy_library_into_null_safe, prefer_interpolation_to_compose_strings, dead_code, avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/models/user.dart';

String url = "http://localhost:1000/api/user";

class UserApiService{
    Future<List<User>> getAllUser() async{
      final res = await http.get(url + '/users');

      if(res.statusCode == 200){
        List listResponse = json.decode(res.body);
        return listResponse.map((u) => User.fromJson(u)).toList();
        print("Users : $listResponse");
      }
      else{
        throw Exception('Fail to load data in users');
      }
    }

    Future<User> deleteUser (String id) async{
      final res = await http.delete(url + '/$id');

      if(res.statusCode == 200){
        return User.fromJson(json.decode(res.body));
      }
      else{
        throw Exception('Fail to delete users');
      }
    }
}