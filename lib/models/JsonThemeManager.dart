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


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';

class JSONThemeManager {
  static ThemeData? _themeData;

  static ThemeData? get themeData => _themeData;

  // Load and set the theme from a JSON file
  static Future<void> loadAndSetTheme(BuildContext context, String jsonAssetPath) async {
    try {
      String jsonString = await rootBundle.loadString(jsonAssetPath);
      Map<String, dynamic> themeJson = json.decode(jsonString);

      final theme = ThemeDecoder.decodeThemeData(themeJson)!;

      _setThemeData(theme);
    } catch (e) {
      // Handle errors, e.g., JSON parsing error or missing theme properties
      print("Error loading theme: $e");
    }
  }

  // Set the theme data
  static void _setThemeData(ThemeData theme) {
    _themeData = theme;
  }
}
