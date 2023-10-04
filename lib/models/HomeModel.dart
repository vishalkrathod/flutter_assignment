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
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  String name;
  String accountNumber;
  double balance;
  String currency;
  Address address;
  List<RecentTransaction> recentTransactions;
  List<RecentTransaction> upcomingBills;

  HomeModel({
    required this.name,
    required this.accountNumber,
    required this.balance,
    required this.currency,
    required this.address,
    required this.recentTransactions,
    required this.upcomingBills,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    name: json["name"],
    accountNumber: json["accountNumber"],
    balance: json["balance"]?.toDouble(),
    currency: json["currency"],
    address: Address.fromJson(json["address"]),
    recentTransactions: List<RecentTransaction>.from(json["recentTransactions"].map((x) => RecentTransaction.fromJson(x))),
    upcomingBills: List<RecentTransaction>.from(json["upcomingBills"].map((x) => RecentTransaction.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "accountNumber": accountNumber,
    "balance": balance,
    "currency": currency,
    "address": address.toJson(),
    "recentTransactions": List<dynamic>.from(recentTransactions.map((x) => x.toJson())),
    "upcomingBills": List<dynamic>.from(upcomingBills.map((x) => x.toJson())),
  };

}

class Address {
  String streetName;
  String buildingNumber;
  String townName;
  String postCode;
  String country;

  Address({
    required this.streetName,
    required this.buildingNumber,
    required this.townName,
    required this.postCode,
    required this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    streetName: json["streetName"],
    buildingNumber: json["buildingNumber"],
    townName: json["townName"],
    postCode: json["postCode"],
    country: json["country"],
  );

  Map<String, dynamic> toJson() => {
    "streetName": streetName,
    "buildingNumber": buildingNumber,
    "townName": townName,
    "postCode": postCode,
    "country": country,
  };
}

class RecentTransaction {
  DateTime date;
  String description;
  double amount;
  String fromAccount;
  String toAccount;

  RecentTransaction({
    required this.date,
    required this.description,
    required this.amount,
    required this.fromAccount,
    required this.toAccount,
  });

  factory RecentTransaction.fromJson(Map<String, dynamic> json) => RecentTransaction(
    date: DateTime.parse(json["date"]),
    description: json["description"],
    amount: json["amount"]?.toDouble(),
    fromAccount: json["fromAccount"],
    toAccount: json["toAccount"],
  );

  Map<String, dynamic> toJson() => {
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(1, '0')}-${date.day.toString().padLeft(2, '0')}",
    "description": description,
    "amount": amount,
    "fromAccount": fromAccount,
    "toAccount": toAccount,
  };
}
