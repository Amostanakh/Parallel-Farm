import 'package:parallel_farm/models/token_model.dart';

import 'auth_state.dart';

LoginState loginReducer(LoginState state, dynamic action) {
  LoginState newState = state;

  switch (action.type) {

    case LOGIN_REQUEST:
      newState.error = null;
      newState.loading = true;
      newState.success = null;
      return newState;

    case LOGIN_SUCCESS:
      newState.error = null;
      newState.loading = false;
      newState.success = TokenModel.fromJson(action.payload);
      return newState;

    case LOGIN_FAILURE:
      newState.error = action.error;
      newState.loading = false;
      newState.success = null;
      return newState;

    default:
      return state;
  }
}const LOGIN_REQUEST = 'LOGIN_REQUEST';
const LOGIN_SUCCESS = 'LOGIN_SUCCESS';
const LOGIN_FAILURE = 'LOGIN_FAILURE';