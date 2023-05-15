// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String message;
  final String uid;
  final Timestamp timestamp;
  ChatModel({
    required this.message,
    required this.uid,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'uid': uid,
      'timestamp': timestamp,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      message: (map['message'] ?? '') as String,
      uid: (map['uid'] ?? '') as String,
      timestamp: (map['timestamp'] ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) => ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
