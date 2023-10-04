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

import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../GraphQL/Connection.dart';
import '../GraphQL/Queries.dart';
import '../models/AccountsModel.dart';

typedef Emit<State> = void Function(State);

abstract class AccountsEvent {}

class AccountsRequested extends AccountsEvent {
  AccountsRequested();
}

abstract class AccountsState {}

class AccountsInitial extends AccountsState {}

class AccountsLoadInProgress extends AccountsState {}

class AccountsLoadFailure extends AccountsState {
  final String errorMessage;

  AccountsLoadFailure(this.errorMessage);
}

class AccountsLoadSuccess extends AccountsState {
  AccountsLoadSuccess(this.accountsModel);
  final List<AccountsModel> accountsModel;
}

class AccountsBloc extends Bloc<AccountsEvent, AccountsState> {
  AccountsBloc(this.accountsAPIs) : super(AccountsInitial()) {
    on<AccountsRequested>((event, emit) async {
      await _onAccountsRequested(event, emit);
    });
  }

  final AccountsAPIs accountsAPIs;

  Future _onAccountsRequested(AccountsRequested event, Emit<AccountsState> emit) async {
    emit(AccountsLoadInProgress());
    try {
      final result = await accountsAPIs.fetchAccountsData();
      emit(await AccountsLoadSuccess(result));
    } catch (e) {
      emit(await AccountsLoadFailure(e.toString()));
    }
  }
}

class AccountsAPIs {
  GraphQLClient _client = client.value;
  Future<List<AccountsModel>> fetchAccountsData() async {
    List<AccountsModel> jobs = [];

    QueryResult result = await _client.query(QueryOptions(document: gql(getAccountsQuery)));

    if (!result.hasException) {
      List data = result.data!["accounts"];
      List<AccountsModel> model = accountsModelFromJson(json.encode(data));
      jobs = model;
    }
    return jobs;
  }
}
