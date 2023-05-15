import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ResultPinCodeModel {
  final String token;
  final String ref_code;
  ResultPinCodeModel({
    required this.token,
    required this.ref_code,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'ref_code': ref_code,
    };
  }

  factory ResultPinCodeModel.fromMap(Map<String, dynamic> map) {
    return ResultPinCodeModel(
      token: (map['token'] ?? '') as String,
      ref_code: (map['ref_code'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultPinCodeModel.fromJson(String source) => ResultPinCodeModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
