import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login/classes/user.dart';
import 'package:login/const/eaz_api.dart' as prefix0;
import 'package:login/const/eaz_api.dart';
import 'package:login/models/models/CommunicationManager.dart';
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
    try {
      String _username = username;
      String _password = password;

      var _login = {"username": "$_username", "password": "$_password"};
      var login = await Login(User(token: null))
          .post(apiURL + prefix0.login, json.encode(_login));
      //print(_data122);
      SharedPreferences.getInstance().then((prefs) {
        prefs.setString("saved_username", _username);
      });
      if (login == "200") {
        return true;
      } else
        return false;
    } catch (e) {
      print('Error with URL: $e');
    }
  }

  // ignore: missing_return
  Future<bool> changePassword({
    @required String oldPassword,
    @required String newPassword,
    @required String confirmUsername,
  }) async {
    try {
      String _oldPassword = oldPassword;
      String _newPassword = newPassword;
      String _confirmUsername = confirmUsername;
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _username = _prefs.getString("saved_username") ?? "";
      var _changePassword = {
        "oldPassword": "$_oldPassword",
        "newPassword": "$_newPassword",
        "userId": "",
        "username": "$_username"
      };
      var changePassword = await ChangePassword(User(token: null))
          .post(apiURL + change_password, json.encode(_changePassword));
      //print(_data11);
      if (changePassword == "1000") {
        return true;
      } else
        return false;
    } catch (e) {
      print('Error with URL: $e');
    }
  }

  // ignore: missing_return
  Future<bool> forgotPassword({
    @required String username,
  }) async {
    try {
      String _username = username;
      var _forgotPassword = {"mobileNumber": "$_username"};
      var changePassword = await ForgotPassword(User(token: null))
          .post(apiURL + send_OTP, json.encode(_forgotPassword));
      SharedPreferences.getInstance().then((prefs) {
        prefs.setString("mobileNumber", _username);
      });
      if (changePassword == "1000") {
        return true;
      } else
        return false;
    } catch (e) {
      print('Error with URL: $e');
    }
  }

  // ignore: missing_return
  Future<bool> submitOTP({
    @required String otp,
  }) async {
    try {
      String _otp = otp;
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _username = _prefs.getString("mobileNumber") ?? "";
      var _forgotPassword = {"mobileNumber": "$_username", "otp": "$_otp"};
      var changePassword = await SubmitOTP(User(token: null))
          .post(apiURL + forgot_password, json.encode(_forgotPassword));
      if (changePassword == "1000") {
        return true;
      } else
        return false;
    } catch (e) {
      print('Error with URL: $e');
    }
  }

  // ignore: missing_return
  Future<bool> resetPassword({
    @required String newPassword,
    @required String confirmPassword,
  }) async {
    try {
      String _newPassword = newPassword;
      String _confirmPassword = confirmPassword;
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _username = _prefs.getString("mobileNumber") ?? "";
      var _forgotPassword = {
        "oldPassword": "$_newPassword",
        "newPassword": "$_confirmPassword",
        "username": "$_username"
      };
      var changePassword = await ResetPassword(User(token: null))
          .post(apiURL + change_password, json.encode(_forgotPassword));
      if (changePassword == "1000") {
        return true;
      } else
        return false;
    } catch (e) {
      print('Error with URL: $e');
    }
  }

  // ignore: missing_return
  Future<bool> sendSMS({
    @required String smsDescreption,
    //@required String smsType,
  }) async {
    try {
      String _smsDescription = smsDescreption;
      //String _smsType = smsType;
      // Getting Account Id
      SharedPreferences _accountId = await SharedPreferences.getInstance();
      var id = _accountId.getString("saved_accountId") ?? "";

      // Getting custId
      SharedPreferences _custId = await SharedPreferences.getInstance();
      var custId = _custId.getString("saved_custId") ?? "";

      //Getting AcademicYearsId
      SharedPreferences _academicYearId = await SharedPreferences.getInstance();
      var academicYearId =
          _academicYearId.getString("saved_acedmicYearId") ?? "";

      //Getting Receiver Type
      SharedPreferences _receiverType = await SharedPreferences.getInstance();
      var receiverType = _receiverType.getString("recever_type") ?? "";

      var _submit = {
        "identifier": {
          "accountId": "$id",
          "custId": "$custId",
          "academicYearId": "$academicYearId"
        },
        "messagesVOs": [
          {
            "receiverType": "$receiverType",
            "messageType": "",
            "title": "",
            "purposeType": "",
            "classIds": "",
            "messageDescription": "$_smsDescription",
            "otherMobileNos": "",
            "otherType": "",
            "messageSalutation": "",
            "status": "M"
          }
        ]
      };
      var login = await SendSMS(User(token: null))
          .post(apiURL + send_SMS, json.encode(_submit));
      if (login == "1000") {
        return true;
      } else
        return false;
    } catch (e) {
      print('Error with URL: $e');
    }
  }

  // ignore: missing_return
  Future<bool> applyLeave({
    @required String leaveDescreption,
    @required String lastDate,
    @required String startDate,
  }) async {
    try {
      String _leaveDescreption = leaveDescreption;
      String _starDate = startDate;
      String _endDate = lastDate;
      // Getting Account Id
      SharedPreferences _accountId = await SharedPreferences.getInstance();
      var id = _accountId.getString("saved_accountId") ?? "";

      // Getting custId
      SharedPreferences _custId = await SharedPreferences.getInstance();
      var custId = _custId.getString("saved_custId") ?? "";

      //Getting AcademicYearsId
      SharedPreferences _academicYearId = await SharedPreferences.getInstance();
      var academicYearId =
          _academicYearId.getString("saved_acedmicYearId") ?? "";

      SharedPreferences _receiverType = await SharedPreferences.getInstance();
      var _leavesType = _receiverType.getString("leave_type") ?? "";

      var _submit = {
        "accountId": "$id",
        "appliedBy": "S",
        "description": "$_leaveDescreption",
        "endDate": "$_endDate",
        "halfDayLeave": false,
        "id": 0,
        "leaveSessionType": "",
        "leaveStatus": "P",
        "leaveType": "$_leavesType",
        "leavesCount": "",
        "startDate": "$_starDate",
        "supervisorId": 0,
        "identifier": {
          "accountId": "$id",
          "custId": "$custId",
          "academicYearId": "$academicYearId"
        }
      };
      var login = await ApplyLeave(User(token: null))
          .post(apiURL + applyLeaves, json.encode(_submit));
      if (login == "1000") {
        return true;
      } else
        return false;
    } catch (e) {
      print('Error with URL: $e');
    }
  }

  // ignore: missing_return
  Future<bool> deleteLeave({
    @required String leaveId,
  }) async {
    try {
      //Getting deleting leave id
      SharedPreferences _leaveIds = await SharedPreferences.getInstance();
      var _leaveId = _leaveIds.getString("delete_leave_id") ?? "";

      var login = await DeleteLeave(User(token: null))
          .delete(apiURL + deleteLeaves + _leaveId);
      if (login == "1021") {
        return true;
      } else
        return false;
    } catch (e) {
      print('Error with URL: $e');
    }
  }

  // ignore: non_constant_identifier_names, missing_return
  Future<bool> SendSingleStudentSMS({
    @required String smsDescreption,
  }) async {
    try {
      String _smsDescription = smsDescreption;
      //String _smsType = smsType;
      SharedPreferences _personAccountId =
          await SharedPreferences.getInstance();
      var personId = _personAccountId.getString("staff_person_number") ?? "";
      // Getting Account Id
      SharedPreferences _accountId = await SharedPreferences.getInstance();
      var id = _accountId.getString("saved_accountId") ?? "";

      // Getting custId
      SharedPreferences _custId = await SharedPreferences.getInstance();
      var custId = _custId.getString("saved_custId") ?? "";

      //Getting AcademicYearsId
      SharedPreferences _academicYearId = await SharedPreferences.getInstance();
      var academicYearId =
          _academicYearId.getString("saved_acedmicYearId") ?? "";

      var _submit = {
        "identifier": {
          "accountId": "$id",
          "custId": "$custId",
          "academicYearId": "$academicYearId"
        },
        "messagesVOs": [
          {
            "receiverType": "",
            "messageType": "",
            "title": "",
            "purposeType": "",
            "classIds": "",
            "messageDescription": "$_smsDescription",
            "otherMobileNos": "",
            "otherType": "",
            "messageSalutation": "",
            "status": "M",
            "studentAccountIds": "$personId"
          }
        ]
      };
      var send = await SendSMS(User(token: null))
          .post(apiURL + send_SMS, json.encode(_submit));
      if (send == "1000") {
        return true;
      } else
        return false;
    } catch (e) {
      print('Error with URL: $e');
    }
  }

  // ignore: non_constant_identifier_names, missing_return
  Future<bool> SendSingleStaffSMS({
    @required String smsDescreption,
  }) async {
    try {
      String _smsDescription = smsDescreption;
      //String _smsType = smsType;
      SharedPreferences _personAccountId =
          await SharedPreferences.getInstance();
      var personId = _personAccountId.getString("staff_person_number") ?? "";
      // Getting Account Id
      SharedPreferences _accountId = await SharedPreferences.getInstance();
      var id = _accountId.getString("saved_accountId") ?? "";

      // Getting custId
      SharedPreferences _custId = await SharedPreferences.getInstance();
      var custId = _custId.getString("saved_custId") ?? "";

      //Getting AcademicYearsId
      SharedPreferences _academicYearId = await SharedPreferences.getInstance();
      var academicYearId =
          _academicYearId.getString("saved_acedmicYearId") ?? "";

      var _submit = {
        "identifier": {
          "accountId": "$id",
          "custId": "$custId",
          "academicYearId": "$academicYearId"
        },
        "messagesVOs": [
          {
            "receiverType": "S",
            "messageType": "",
            "title": "",
            "purposeType": "",
            "classIds": "",
            "messageDescription": "$_smsDescription",
            "otherMobileNos": "",
            "otherType": "",
            "messageSalutation": "",
            "status": "M",
            "studentAccountIds": "$personId"
          }
        ]
      };
      var send = await SendSMS(User(token: null))
          .post(apiURL + send_SMS, json.encode(_submit));
      if (send == "1000") {
        return true;
      } else
        return false;
    } catch (e) {
      print('Error with URL: $e');
    }
  }
}
