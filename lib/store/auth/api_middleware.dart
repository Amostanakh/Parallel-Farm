
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:redux/redux.dart';

import '../AppState.dart';

void apiMiddleware(Store<AppState> store, dynamic action, NextDispatcher next)
async {

  next(action);
}