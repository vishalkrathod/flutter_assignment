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
import 'package:bloc/bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../GraphQL/Connection.dart';
import '../GraphQL/Queries.dart';
import '../models/HomeModel.dart';

typedef Emit<State> = void Function(State);

abstract class HomeEvent {}

class HomeRequested extends HomeEvent {
  HomeRequested();
}

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadInProgress extends HomeState {}

class HomeLoadFailure extends HomeState {
  final String errorMessage;

  HomeLoadFailure(this.errorMessage);
}

class HomeLoadSuccess extends HomeState {
  HomeLoadSuccess(this.homeModel);
  final HomeModel homeModel;
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(this.homeAPIs) : super(HomeInitial()) {
    on<HomeRequested>((event, emit) async {
      await _onHomeRequested(event, emit);
    });
  }

  final HomeAPIs homeAPIs;

  Future _onHomeRequested(HomeRequested event, Emit<HomeState> emit) async {
    emit(HomeLoadInProgress());
    try {
      final result = await homeAPIs.fetchHomeData();
      emit(await HomeLoadSuccess(result.first));
    } catch (e) {
      emit(await HomeLoadFailure(e.toString()));
    }
  }
}

class HomeAPIs {
  GraphQLClient _client = client.value;
  Future<List<HomeModel>> fetchHomeData() async {
    List<HomeModel> jobs = [];

    QueryResult result = await _client.query(QueryOptions(document: gql(getHomeQuery)));

    if (!result.hasException) {
      Map<String, dynamic> data = result.data!["home"];
      HomeModel model = HomeModel.fromJson(data);
      jobs.add(model);
    }
    return jobs;
  }
}
