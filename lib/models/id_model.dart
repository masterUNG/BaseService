import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class IdModel {
  final String id;
  IdModel({
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
    };
  }

  factory IdModel.fromMap(Map<String, dynamic> map) {
    return IdModel(
      id: (map['id'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory IdModel.fromJson(String source) => IdModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
