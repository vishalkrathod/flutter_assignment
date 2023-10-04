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
import '../models/TransactionsModel.dart';

typedef Emit<State> = void Function(State);

abstract class TransactionsEvent {}

class TransactionsRequested extends TransactionsEvent {
  TransactionsRequested();
}

abstract class TransactionsState {}

class TransactionsInitial extends TransactionsState {}

class TransactionsLoadInProgress extends TransactionsState {}

class TransactionsLoadFailure extends TransactionsState {
  final String errorMessage;

  TransactionsLoadFailure(this.errorMessage);
}

class TransactionsLoadSuccess extends TransactionsState {
  TransactionsLoadSuccess(this.transactionsModel);
  final List<TransactionsModel> transactionsModel;
}

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  TransactionsBloc(this.transactionsAPIs) : super(TransactionsInitial()) {
    on<TransactionsRequested>((event, emit) async {
      await _onTransactionsRequested(event, emit);
    });
  }

  final TransactionsAPIs transactionsAPIs;

  Future _onTransactionsRequested(TransactionsRequested event, Emit<TransactionsState> emit) async {
    emit(TransactionsLoadInProgress());
    try {
      final result = await transactionsAPIs.fetchTransactionsData();
      emit(await TransactionsLoadSuccess(result));
    } catch (e) {
      emit(await TransactionsLoadFailure(e.toString()));
    }
  }
}

class TransactionsAPIs {
  GraphQLClient _client = client.value;
  Future<List<TransactionsModel>> fetchTransactionsData() async {
    List<TransactionsModel> jobs = [];

    QueryResult result = await _client.query(QueryOptions(document: gql(getTransactionsQuery)));

    if (!result.hasException) {
      List data = result.data!["transactions"];
      List<TransactionsModel> model = transactionsModelFromJson(json.encode(data));
      jobs = model;
    }
    return jobs;
  }
}

