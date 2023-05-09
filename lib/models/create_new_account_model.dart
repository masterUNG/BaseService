import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CreateNewAccountModel {
  final String LoginName;
  final String id;
  final String email;
  final String password;
  final String Name;
  final String Lname;
  CreateNewAccountModel({
    required this.LoginName,
    required this.id,
    required this.email,
    required this.password,
    required this.Name,
    required this.Lname,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'LoginName': LoginName,
      'id': id,
      'email': email,
      'password': password,
      'Name': Name,
      'Lname': Lname,
    };
  }

  factory CreateNewAccountModel.fromMap(Map<String, dynamic> map) {
    return CreateNewAccountModel(
      LoginName: (map['LoginName'] ?? '') as String,
      id: (map['id'] ?? '') as String,
      email: (map['email'] ?? '') as String,
      password: (map['password'] ?? '') as String,
      Name: (map['Name'] ?? '') as String,
      Lname: (map['Lname'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateNewAccountModel.fromJson(String source) => CreateNewAccountModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
