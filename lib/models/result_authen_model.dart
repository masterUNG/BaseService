import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ResultAuthenModel {
  final String token;
  final int expiresIn;
  final String userData;
  final String LoginName;
  final String USERID;
  final String FULLNAME;
  final String MSG_CODE;
  final String MSG_DESC;
  final String MktId;
  final String User_Level;
  ResultAuthenModel({
    required this.token,
    required this.expiresIn,
    required this.userData,
    required this.LoginName,
    required this.USERID,
    required this.FULLNAME,
    required this.MSG_CODE,
    required this.MSG_DESC,
    required this.MktId,
    required this.User_Level,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'expiresIn': expiresIn,
      'userData': userData,
      'LoginName': LoginName,
      'USERID': USERID,
      'FULLNAME': FULLNAME,
      'MSG_CODE': MSG_CODE,
      'MSG_DESC': MSG_DESC,
      'MktId': MktId,
      'User_Level': User_Level,
    };
  }

  factory ResultAuthenModel.fromMap(Map<String, dynamic> map) {
    return ResultAuthenModel(
      token: (map['token'] ?? '') as String,
      expiresIn: (map['expiresIn'] ?? 0) as int,
      userData: (map['userData'] ?? '') as String,
      LoginName: (map['LoginName'] ?? '') as String,
      USERID: (map['USERID'] ?? '') as String,
      FULLNAME: (map['FULLNAME'] ?? '') as String,
      MSG_CODE: (map['MSG_CODE'] ?? '') as String,
      MSG_DESC: (map['MSG_DESC'] ?? '') as String,
      MktId: (map['MktId'] ?? '') as String,
      User_Level: (map['User_Level'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultAuthenModel.fromJson(String source) => ResultAuthenModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
