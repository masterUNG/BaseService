import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ResultModel {
  final String result;
  ResultModel({
    required this.result,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'result': result,
    };
  }

  factory ResultModel.fromMap(Map<String, dynamic> map) {
    return ResultModel(
      result: (map['result'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultModel.fromJson(String source) => ResultModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
