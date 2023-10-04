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
import 'package:flutter_assignment/bloc/HomeBloc.dart';
import 'package:flutter_assignment/models/HomeModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadInProgress) {
              return CircularProgressIndicator();
            } else if (state is HomeLoadSuccess) {
              // Display your data here
              return ListView(
                padding: EdgeInsets.all(16.0),
                children: [
                  Text(
                    'Welcome, ${state.homeModel.name}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 24),
                  AccountCard(homeModel: state.homeModel),
                  SizedBox(height: 24),

                  Text(
                    'Recent Transactions',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  TransactionList(homeModel: state.homeModel),

                  SizedBox(height: 24),
                  Text(
                    'Upcoming Bills',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  UpcomingBillList(homeModel: state.homeModel),


                ],
              );
            } else if (state is HomeLoadFailure) {
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

class AccountCard extends StatelessWidget {
  final HomeModel homeModel;

  const AccountCard({super.key, required this.homeModel});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280, // Adjust the height to your preference
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
              '${homeModel.accountNumber}', // Replace with your account number
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Spacer(),
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
              '\$${homeModel.balance}', // Replace with your balance
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Address',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              '${homeModel.address.streetName}, ${homeModel.address.buildingNumber}, ${homeModel.address.townName}, ${homeModel.address.country}, ${homeModel.address.postCode}', // Replace with your address
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }
}

class TransactionList extends StatelessWidget {
  final HomeModel homeModel;

  const TransactionList({super.key, required this.homeModel});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: homeModel.recentTransactions.length,
      itemBuilder: (context, index) {
        String formattedDate = DateFormat('dd MMM yyyy hh:mm a').format(homeModel.recentTransactions[index].date);
        return TransactionItem(
          title: '${homeModel.recentTransactions[index].description}',
          amount: '\$${homeModel.recentTransactions[index].amount}',
          date: '${formattedDate}',
        );
      },
    );
  }
}

class TransactionItem extends StatelessWidget {
  final String title;
  final String amount;
  final String date;

  TransactionItem({required this.title, required this.amount, required this.date});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(date),
        trailing: Text(amount),
      ),
    );
  }
}

class UpcomingBillList extends StatelessWidget {
  final HomeModel homeModel;

  const UpcomingBillList({super.key, required this.homeModel});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: homeModel.upcomingBills.length,
      itemBuilder: (context, index) {
        String formattedDate = DateFormat('dd MMM yyyy hh:mm a').format(homeModel.upcomingBills[index].date);
        return UpcomingBillItem(
          title: '${homeModel.upcomingBills[index].description}',
          amount: '\$${homeModel.upcomingBills[index].amount}',
          dueDate: '${formattedDate}',
        );
      },
    );
  }
}

class UpcomingBillItem extends StatelessWidget {
  final String title;
  final String amount;
  final String dueDate;

  UpcomingBillItem({required this.title, required this.amount, required this.dueDate});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text('Due Date: $dueDate'),
        trailing: Text(amount),
      ),
    );
  }
}
