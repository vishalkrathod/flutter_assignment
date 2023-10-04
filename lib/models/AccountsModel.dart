/*
 * **************************************************************************************
 *  * Copyright (c) 2023. Vishal Rathod
 *  *
 *  * All rights reserved. This work, including but not limited to all source code, images,
 *  * graphics, icons, and text, is the property of Vishal Rathod, a mobile app developer,
 *  * and is protected by copyright laws and international treaties.
 *  *
 *  * Unauthorized reproduction or distribution of this work, or any portion thereof,
 *  * may result in severe civil and criminal penalties and will be prosecuted
 *  * to the maximum extent possible under the law.
 *  *
 *  * For inquiries regarding licensing, usage, or any other questions, please contact:
 *  *
 *  * Vishal Rathod
 *  * Mobile App Developer
 *  *
 *  * This copyright notice applies to all projects, applications, and codebases developed
 *  * by Vishal Rathod using Android Studio or any other development tools. Any use of this
 *  * work, including but not limited to copying, modifying, or distributing it without
 *  * explicit written consent from Vishal Rathod, is strictly prohibited.
 *  **************************************************************************************
 *
 */

// To parse this JSON data, do
//
//     final accountsModel = accountsModelFromJson(jsonString);

import 'dart:convert';

List<AccountsModel> accountsModelFromJson(String str) => List<AccountsModel>.from(json.decode(str).map((x) => AccountsModel.fromJson(x)));

String accountsModelToJson(List<AccountsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AccountsModel {
  String id;
  String accountNumber;
  AccountType accountType;
  double balance;
  String accountHolder;

  AccountsModel({
    required this.id,
    required this.accountNumber,
    required this.accountType,
    required this.balance,
    required this.accountHolder,
  });

  factory AccountsModel.fromJson(Map<String, dynamic> json) => AccountsModel(
    id: json["id"],
    accountNumber: json["accountNumber"],
    accountType: accountTypeValues.map[json["accountType"]]!,
    balance: json["balance"]?.toDouble(),
    accountHolder: json["accountHolder"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "accountNumber": accountNumber,
    "accountType": accountTypeValues.reverse[accountType],
    "balance": balance,
    "accountHolder": accountHolder,
  };
}

enum AccountType {
  CHECKING,
  SAVINGS
}

final accountTypeValues = EnumValues({
  "Checking": AccountType.CHECKING,
  "Savings": AccountType.SAVINGS
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
