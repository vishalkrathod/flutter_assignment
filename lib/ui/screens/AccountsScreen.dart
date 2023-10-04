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
import 'package:flutter_assignment/bloc/AccountsBloc.dart';
import 'package:flutter_assignment/models/AccountsModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AccountsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Accounts'),
      ),
      body: Center(
        child: BlocBuilder<AccountsBloc, AccountsState>(
          builder: (context, state) {
            if (state is AccountsLoadInProgress) {
              return CircularProgressIndicator();
            } else if (state is AccountsLoadSuccess) {
              // Display your data here
              return ListView.builder(
                itemCount: state.accountsModel.length,
                padding: EdgeInsets.all(16.0),
                itemBuilder: (context, index) {
                  final account = state.accountsModel[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: AccountsCard(accountsModel: account),
                  );
                },
              );
            } else if (state is AccountsLoadFailure) {
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

class AccountsCard extends StatelessWidget {
  final AccountsModel accountsModel;

  const AccountsCard({super.key, required this.accountsModel});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push("/transactions_screen",extra: accountsModel);
      },
      child: Container(
        height: 250, // Adjust the height to your preference
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: Theme.of(context).primaryColor, // You can change the background color
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Name',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '${accountsModel.accountHolder}', // Replace with your address
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Account Number',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        '${accountsModel.accountNumber}', // Replace with your account number
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Account Type',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        '${accountsModel.accountType.name}', // Replace with your account number
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Balance',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    '\$${accountsModel.balance.toStringAsFixed(2)}', // Replace with your balance
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
