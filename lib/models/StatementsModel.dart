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
//     final statementsModel = statementsModelFromJson(jsonString);

import 'dart:convert';

List<StatementsModel> statementsModelFromJson(String str) => List<StatementsModel>.from(json.decode(str).map((x) => StatementsModel.fromJson(x)));

String statementsModelToJson(List<StatementsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StatementsModel {
  DateTime date;
  String description;
  double amount;

  StatementsModel({
    required this.date,
    required this.description,
    required this.amount,
  });

  factory StatementsModel.fromJson(Map<String, dynamic> json) => StatementsModel(
    date: DateTime.parse(json["date"]),
    description: json["description"],
    amount: json["amount"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "description": description,
    "amount": amount,
  };
}
