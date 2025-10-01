import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:product/Model/user_model.dart';
import 'package:product/services/api_client.dart';
import 'package:product/services/auth_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  
  final formKey = GlobalKey<FormBuilderState>();
  final AuthServices _authServices = AuthServices();
  UserData? userData;



  UserProvider(){
    loaddata();
  }


  void login(contex) async {
    formKey.currentState?.saveAndValidate();
    if (formKey.currentState!.isValid) {
      userData = await _authServices.authData(
        formKey.currentState!.value["email"],
        formKey.currentState!.value["pass"],
        contex,
      );
    }
    notifyListeners();
  }

  Future loaddata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? username = prefs.getString("userData");

    if (username != null) {
      dynamic da = jsonDecode(username);

      userData= UserData.fromJson(da);

      notifyListeners();

    }
    else{
      userData=null;
    }
  }
}
