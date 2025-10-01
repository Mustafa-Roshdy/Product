
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:product/Model/user_model.dart';
import 'package:product/services/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {


  

  final ApiClient _apiClient = ApiClient();

  Future<UserData?> authData(String username, String pass ,BuildContext context) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      Response res = await _apiClient.postData("/auth/login", {
        "username": username,
        "password": pass,
      }, {});

      if (res.statusCode == 200 || res.statusCode == 201) {

        UserData userData = UserData.fromJson(res.data);
        prefs.setString("userData", jsonEncode(userData.toJson()));
        const snackdemo = SnackBar(
          content: Text('Login Done!'),
          backgroundColor: Colors.green,
          elevation: 10,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(5),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackdemo);
        Future.delayed(Duration(seconds: 2), () async {
          Navigator.pushReplacementNamed(context, "/switch");
        });

        return userData;
      }
      
    } catch (e) {
      if (kDebugMode) {
        const snackdemo = SnackBar(
          content: Text('Login Failed'),
          backgroundColor: Colors.red,
          elevation: 10,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(5),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackdemo);
      }
      return null;
    }
  }
}