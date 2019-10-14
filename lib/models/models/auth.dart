import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login/classes/user.dart';
import 'package:login/models/models/web_client.dart';
import 'package:login/utils/webConfig.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthModel extends Model {
  String errorMessage = "";
  User _user;
  User get user => _user;

  // ignore: missing_return
  Future<bool> login({
    @required String username,
    @required String password,
  }) async {
    try{
    String _username = username;
    String _password = password;

    var _login={"username":"$_username","password":"$_password"} ;
    var login = await WebClient(User(token: null)).post(apiURL+"/api/authenticate",json.encode(_login));
    //print(_data122);
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("saved_username", _username);
    });
    if(login == "200"){
      return true;
    }else
      return false;
    }
    catch  (e) {
  print('Error with URL: $e');
  }

  }

  // ignore: missing_return
  Future<bool> changePassword ({
    @required String oldPassword,
    @required String newPassword,
    @required String confirmUsername,
  })async{
   try{
      String _oldPassword = oldPassword;
      String _newPassword = newPassword;
      String _confirmUsername = confirmUsername;
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _username = _prefs.getString("saved_username") ?? "";
      var _changePassword={"oldPassword":"$_oldPassword","newPassword":"$_newPassword","userId":"","username":"$_username"};
      var changePassword= await WebClient(User(token: null)).post(apiURL+"/api/changePassword", json.encode(_changePassword));
      //print(_data11);
      if(changePassword=="1000"){
        return true;
      }else
        return false;
    }catch (e){
         print('Error with URL: $e');
    }
  }

    // ignore: missing_return
    Future<bool> forgotPassword ({
      @required String username,
    })async{
      try{
        String _username = username;
        var _forgotPassword={"mobileNumber":"$_username"};
        var changePassword= await WebClient(User(token: null)).post(apiURL+"/api/forgotPasswordSendOTP", json.encode(_forgotPassword));
        SharedPreferences.getInstance().then((prefs) {
          prefs.setString("mobileNumber", _username);
        });
        if(changePassword=="1000"){
          return true;
        }else
          return false;
      }catch (e){
        print('Error with URL: $e');
      }
    }

  // ignore: missing_return
  Future<bool> submitOTP ({
    @required String otp,
  })async{
    try{
      String _otp = otp;
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _username = _prefs.getString("mobileNumber") ?? "";
      var _forgotPassword={"mobileNumber":"$_username","otp":"$_otp"};
      var changePassword= await WebClient(User(token: null)).post(apiURL+"/api/verifyForgotPasswordOTP", json.encode(_forgotPassword));
      if(changePassword=="1000"){
        return true;
      }else
        return false;
    }catch (e){
      print('Error with URL: $e');
    }
  }

  // ignore: missing_return
  Future<bool> resetPassword ({
    @required String newPassword,
    @required String confirmPassword,
  })async{
    try{
      String _newPassword = newPassword;
      String _confirmPassword = confirmPassword;
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _username = _prefs.getString("mobileNumber") ?? "";
      var _forgotPassword={"oldPassword":"$_newPassword","newPassword":"$_confirmPassword","username":"$_username"};
      var changePassword= await WebClient(User(token: null)).post(apiURL+"/api/changePassword", json.encode(_forgotPassword));
      if(changePassword=="1000"){
        return true;
      }else
        return false;
    }catch (e){
      print('Error with URL: $e');
    }
  }
}