import 'dart:convert';

import 'package:baseservice/utility/app_service.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class TransectionModel {
  final String amcNameE;
  final String fundNameT;
  final String fundNameE;
  final String Amc_Name;
  final String FGroup_Code;
  final String Fund_Code;
  final String TranType_Code;
  final String Ref_No;
  final String TranDate;
  final double Amount_Baht;
  final double Amount_Unit;
  final double Nav_Price;
  final double Avg_Cost;
  final double Cost_Amount_Baht;
  final double RGL;
  final double RGLP;
  final String Act_ExecDate;
  final int Tran_Id;
  final int Fund_Id;
  final int Seq_No;
  TransectionModel({
    required this.amcNameE,
    required this.fundNameT,
    required this.fundNameE,
    required this.Amc_Name,
    required this.FGroup_Code,
    required this.Fund_Code,
    required this.TranType_Code,
    required this.Ref_No,
    required this.TranDate,
    required this.Amount_Baht,
    required this.Amount_Unit,
    required this.Nav_Price,
    required this.Avg_Cost,
    required this.Cost_Amount_Baht,
    required this.RGL,
    required this.RGLP,
    required this.Act_ExecDate,
    required this.Tran_Id,
    required this.Fund_Id,
    required this.Seq_No,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'amcNameE': amcNameE,
      'fundNameT': fundNameT,
      'fundNameE': fundNameE,
      'Amc_Name': Amc_Name,
      'FGroup_Code': FGroup_Code,
      'Fund_Code': Fund_Code,
      'TranType_Code': TranType_Code,
      'Ref_No': Ref_No,
      'TranDate': TranDate,
      'Amount_Baht': Amount_Baht,
      'Amount_Unit': Amount_Unit,
      'Nav_Price': Nav_Price,
      'Avg_Cost': Avg_Cost,
      'Cost_Amount_Baht': Cost_Amount_Baht,
      'RGL': RGL,
      'RGLP': RGLP,
      'Act_ExecDate': Act_ExecDate,
      'Tran_Id': Tran_Id,
      'Fund_Id': Fund_Id,
      'Seq_No': Seq_No,
    };
  }

  factory TransectionModel.fromMap(Map<String, dynamic> map) {
    return TransectionModel(
      amcNameE: (map['amcNameE'] ?? '') as String,
      fundNameT: (map['fundNameT'] ?? '') as String,
      fundNameE: (map['fundNameE'] ?? '') as String,
      Amc_Name: (map['Amc_Name'] ?? '') as String,
      FGroup_Code: (map['FGroup_Code'] ?? '') as String,
      Fund_Code: (map['Fund_Code'] ?? '') as String,
      TranType_Code: (map['TranType_Code'] ?? '') as String,
      Ref_No: (map['Ref_No'] ?? '') as String,
      TranDate: (map['TranDate'] ?? '') as String,
      Amount_Baht:
          AppService().checkDouble(testDouble: map['Amount_Baht']) ?? 0.0,
      Amount_Unit:
          AppService().checkDouble(testDouble: map['Amount_Unit']) ?? 0.0,
      Nav_Price: AppService().checkDouble(testDouble: map['Nav_Price']) ?? 0.0,
      Avg_Cost: AppService().checkDouble(testDouble: map['Avg_Cost']) ?? 0.0,
      Cost_Amount_Baht:
          AppService().checkDouble(testDouble: map['Cost_Amount_Baht']) ?? 0.0,
      RGL: AppService().checkDouble(testDouble: map['RGL']) ?? 0.0,
      RGLP: AppService().checkDouble(testDouble: map['RGLP']) ?? 0.0,
      Act_ExecDate: (map['Act_ExecDate'] ?? '') as String,
      Tran_Id: (map['Tran_Id'] ?? 0) as int,
      Fund_Id: (map['Fund_Id'] ?? 0) as int,
      Seq_No: (map['Seq_No'] ?? 0) as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransectionModel.fromJson(String source) =>
      TransectionModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
