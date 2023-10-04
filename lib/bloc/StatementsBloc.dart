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
import '../models/StatementsModel.dart';

typedef Emit<State> = void Function(State);

abstract class StatementsEvent {}

class StatementsRequested extends StatementsEvent {
  StatementsRequested();
}

abstract class StatementsState {}

class StatementsInitial extends StatementsState {}

class StatementsLoadInProgress extends StatementsState {}

class StatementsLoadFailure extends StatementsState {
  final String errorMessage;

  StatementsLoadFailure(this.errorMessage);
}

class StatementsLoadSuccess extends StatementsState {
  StatementsLoadSuccess(this.statementsModel);
  final List<StatementsModel> statementsModel;
}

class StatementsBloc extends Bloc<StatementsEvent, StatementsState> {
  StatementsBloc(this.statementsAPIs) : super(StatementsInitial()) {
    on<StatementsRequested>((event, emit) async {
      await _onStatementsRequested(event, emit);
    });
  }

  final StatementsAPIs statementsAPIs;

  Future _onStatementsRequested(StatementsRequested event, Emit<StatementsState> emit) async {
    emit(StatementsLoadInProgress());
    try {
      final result = await statementsAPIs.fetchStatementsData();
      emit(await StatementsLoadSuccess(result));
    } catch (e) {
      emit(await StatementsLoadFailure(e.toString()));
    }
  }
}

class StatementsAPIs {
  GraphQLClient _client = client.value;
  Future<List<StatementsModel>> fetchStatementsData() async {
    List<StatementsModel> jobs = [];

    QueryResult result = await _client.query(QueryOptions(document: gql(getStatementsQuery)));

    if (!result.hasException) {
      List data = result.data!["statements"];
      List<StatementsModel> model = statementsModelFromJson(json.encode(data));
      jobs = model;
    }
    return jobs;
  }
}
