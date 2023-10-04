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
import 'package:flutter_assignment/models/AccountsModel.dart';
import 'package:flutter_assignment/models/TransactionsModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../bloc/TransactionsBloc.dart';
import 'HomeScreen.dart';

class TransactionsScreen extends StatefulWidget {
  final AccountsModel accountsModel;

  const TransactionsScreen({super.key, required this.accountsModel});
  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: ListTile(
            title: Text(
              '${widget.accountsModel.accountNumber}', // Replace with your address
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold
              ),
            ),
            subtitle: Text(
              '\$${widget.accountsModel.balance.toStringAsFixed(2)}', // Replace with your balance
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Transactions'),
              Tab(text: 'Details'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Transactions Tab
            Container(
              padding: EdgeInsets.all(16.0),
              child:  BlocBuilder<TransactionsBloc, TransactionsState>(
                builder: (context, state) {
                  if (state is TransactionsLoadInProgress) {
                    return CircularProgressIndicator();
                  } else if (state is TransactionsLoadSuccess) {
                    // Display your data here
                    return ListView(
                      padding: EdgeInsets.all(8.0),
                      children: [
                        Text(
                          'Recent Transactions',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        TransactionList(homeModel: state.transactionsModel),
                      ],
                    );
                  } else if (state is TransactionsLoadFailure) {
                    return Text('Error: ${state.errorMessage.toString()}');
                  } else {
                    return Text('No data yet.');
                  }
                },
              ),
            ),
            // Details Tab
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
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
                            '${widget.accountsModel.accountHolder}', // Replace with your address
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
                                    '${widget.accountsModel.accountNumber}', // Replace with your account number
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
                                    '${widget.accountsModel.accountType.name}', // Replace with your account number
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
                                '\$${widget.accountsModel.balance.toStringAsFixed(2)}', // Replace with your balance
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
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class TransactionList extends StatelessWidget {
  final List<TransactionsModel> homeModel;

  const TransactionList({super.key, required this.homeModel});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: homeModel.length,
      padding: EdgeInsets.symmetric(vertical: 16.0),
      itemBuilder: (context, index) {
        String formattedDate = DateFormat('dd MMM yyyy hh:mm a').format(homeModel[index].date);
        return TransactionItem(
          title: '${homeModel[index].description}',
          amount: '\$${homeModel[index].amount.toStringAsFixed(2)}',
          date: '${formattedDate}',
        );
      },
    );
  }
}