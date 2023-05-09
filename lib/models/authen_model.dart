import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AuthenModel {
  final String idcard;
  final String password;
  AuthenModel({
    required this.idcard,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idcard': idcard,
      'password': password,
    };
  }

  factory AuthenModel.fromMap(Map<String, dynamic> map) {
    return AuthenModel(
      idcard: (map['idcard'] ?? '') as String,
      password: (map['password'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthenModel.fromJson(String source) => AuthenModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
