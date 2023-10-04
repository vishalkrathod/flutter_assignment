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
import 'package:flutter_assignment/bloc/StatementsBloc.dart';
import 'package:flutter_assignment/models/StatementsModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../models/StatementsModel.dart';
import 'HomeScreen.dart';
import 'StatementsScreen.dart';


class StatementsScreen extends StatefulWidget {
  @override
  State<StatementsScreen> createState() => _StatementsScreenState();
}

class _StatementsScreenState extends State<StatementsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Statements'),
      ),
      body: Center(
        child: BlocBuilder<StatementsBloc, StatementsState>(
          builder: (context, state) {
            if (state is StatementsLoadInProgress) {
              return CircularProgressIndicator();
            } else if (state is StatementsLoadSuccess) {
              // Display your data here
              return ListView(
                padding: EdgeInsets.all(16.0),
                children: [
                  TransactionList(statementsModel: state.statementsModel),

                  SizedBox(height: 24),

                ],
              );
            } else if (state is StatementsLoadFailure) {
              return Text('Error: ${state.errorMessage.toString()}');
            } else {
              return Text('No data yet.');
            }
          },
        ),
      ),
    );
  }
}

class TransactionList extends StatelessWidget {
  final List<StatementsModel> statementsModel;

  const TransactionList({super.key, required this.statementsModel});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: statementsModel.length,
      itemBuilder: (context, index) {
        String formattedDate = DateFormat('dd MMM yyyy hh:mm a').format(statementsModel[index].date);
        return TransactionItem(
          title: '${statementsModel[index].description}',
          amount: '\$${statementsModel[index].amount}',
          date: '${formattedDate}',
        );
      },
    );
  }
}