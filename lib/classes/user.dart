import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {

  User({
    this.token,
    this.id,
    this.firstname,
    this.lastname,
    this.mobile,
    this.role,
    this.designation,
    this.imageUrl,
    this.accountId,
  });

  final int id;

  @JsonKey(name: "first_name")
  final String firstname;

  @JsonKey(name: "last_name")
  final String lastname;

  final int mobile;

  final String role;
  final String designation;
  final String imageUrl;

  final int accountId;

  @JsonKey(nullable: true)
  String  token;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return "$firstname $lastname".toString();
  }
}

