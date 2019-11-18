import 'package:json_annotation/json_annotation.dart';

class Staffs {
  int staffId;
  String firstName;
  String lastName;
  String gender;
  String mobileNumber;
  String phoneNumber;
  String staffType;
  String qualification1;
  String qualification2;
  String designation;
  String email;
  String addressLine1;
  String addressLine2;
  String city;
  String state;
  String postalCode;
  String status;
  String roleName;
  String roleType;
  int accountId;
  int imageId;
  String imageUrl;
  String academicYearId;
  int custId;
  final List<staffPersonAccountDetailsVOS> staffPersonAccountDetailsVO;

  Staffs({
    this.staffId,
    this.firstName,
    this.lastName,
    this.gender,
    this.mobileNumber,
    this.phoneNumber,
    this.staffType,
    this.qualification1,
    this.qualification2,
    this.designation,
    this.email,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.postalCode,
    this.status,
    this.roleName,
    this.roleType,
    this.accountId,
    this.imageId,
    this.imageUrl,
    this.academicYearId,
    this.custId,
    this.staffPersonAccountDetailsVO
  });

  factory Staffs.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['staffPersonAccountDetailsVO'] as List;
    print(list.runtimeType);

    List<staffPersonAccountDetailsVOS> classList = list.map((list) => staffPersonAccountDetailsVOS.fromJson(list)).toList();
    return Staffs(
        staffId:  parsedJson['staffId'],
        firstName: parsedJson['firstName'],
        lastName: parsedJson['lastName'],
        gender: parsedJson['gender'],
        mobileNumber: parsedJson['mobileNumber'],
        phoneNumber: parsedJson['phoneNumber'],
        staffType: parsedJson['staffType'],
        postalCode: parsedJson['postalCode'],
        qualification1: parsedJson['qualification1'],
        qualification2: parsedJson['qualification2'],
        designation: parsedJson['designation'],
        email: parsedJson['email'],
        addressLine1: parsedJson['addressLine1'],
        addressLine2: parsedJson['addressLine2'],
        city: parsedJson['city'],
        state: parsedJson['state'],
        status: parsedJson['status'],
        roleName: parsedJson['roleName'],
        roleType: parsedJson['roleType'],
        accountId: parsedJson['accountId'],
        imageId: parsedJson['imageId'],
        imageUrl: parsedJson['imageUrl'],
        academicYearId: parsedJson['academicYearId'],
        custId: parsedJson['custId'],

        staffPersonAccountDetailsVO: classList
    );
  }
}

// ignore: camel_case_types
class staffPersonAccountDetailsVOS{
  int staffId;
  String firstName;
  String lastName;
  String gender;
  String mobileNumber;
  String phoneNumber;
  String staffType;
  String qualification1;
  String qualification2;
  String designation;
  String email;
  String addressLine1;
  String addressLine2;
  String city;
  String state;
  String postalCode;
  String status;
  String roleName;
  String roleType;
  int accountId;
  int imageId;
  String imageUrl;
  int academicYearId;
  int custId;
  bool isSwitched = false;

  void setIsSwitched (bool isSwitched){
    this.isSwitched = isSwitched;
  }
  bool getIsSwitched(){
    return isSwitched;
  }

  staffPersonAccountDetailsVOS({
    this.staffId,
    this.firstName,
    this.lastName,
    this.gender,
    this.mobileNumber,
    this.phoneNumber,
    this.staffType,
    this.qualification1,
    this.qualification2,
    this.designation,
    this.email,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.postalCode,
    this.status,
    this.roleName,
    this.roleType,
    this.accountId,
    this.imageId,
    this.imageUrl,
    this.academicYearId,
    this.custId
  });
  factory staffPersonAccountDetailsVOS.fromJson(Map<String, dynamic> json) {
    return staffPersonAccountDetailsVOS(
      staffId:  json['staffId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      gender: json['gender'],
      mobileNumber: json['mobileNumber'],
      phoneNumber: json['phoneNumber'],
      staffType: json['staffType'],
      postalCode: json['postalCode'],
      qualification1: json['qualification1'],
      qualification2: json['qualification2'],
      designation: json['designation'],
      email: json['email'],
      addressLine1: json['addressLine1'],
      addressLine2: json['addressLine2'],
      city: json['city'],
      state: json['state'],
      status: json['status'],
      roleName: json['roleName'],
      roleType: json['roleType'].toString(),
      accountId: json['accountId'],
      imageId: json['imageId'],
      imageUrl: json['imageUrl'],
      academicYearId: json['academicYearId'],
      custId: json['custId']
    );
  }
}

