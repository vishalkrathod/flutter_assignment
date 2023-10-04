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


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ServicesScreen extends StatefulWidget {
  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final List<String> services = ['Loans', 'Statements', 'Contacts'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Services'),
      ),
      body: ListView.builder(
        itemCount: services.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: ListTile(
                title: Text(services[index]),
                onTap: () {
                  // Add navigation or actions here for each service
                  // For example, navigate to a new screen based on the selected service.
                  // You can use a switch statement or if-else conditions to handle each service.
                  // For now, we'll print the selected service to the console.
                  switch (index) {
                    case 0:
                      _showSnackbar(context, 'Awesome choice! You selected Loans. 🚀');
                      break;
                    case 1:
                      context.push("/statements_screen");
                      break;
                    case 2:
                      break;
                  }
                },
              ),
            ),
          );
        },
      ),
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }
}