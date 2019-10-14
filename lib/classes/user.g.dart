// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
      token: json['token'] as String,
      id: json['id'] as int,
      firstname: json['first_name'] as String,
      lastname: json['last_name'] as String,
      mobile: json['mobile'] as int,
      role: json['role'] as String,
      designation: json['designation'] as String,
      imageUrl: json['imageUrl'] as String,
      accountId: json['accountId'] as int,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstname,
      'last_name': instance.lastname,
      'token': instance.token,
       'mobile': instance.mobile,
       'role': instance.role,
       'designation': instance.designation,
       'imageUrl': instance.imageUrl,
       'accountId': instance.accountId,
    };
