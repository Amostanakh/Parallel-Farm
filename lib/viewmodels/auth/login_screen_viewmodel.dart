import 'package:dio/dio.dart';
import 'package:parallel_farm/models/token_model.dart';
import 'package:redux/redux.dart';

import '../../store/AppState.dart';
import '../../store/auth/login_action.dart';

class LoginScreenViewModel{
  final Store<AppState> store;
  final bool loading;
  final dynamic error;
  final TokenModel? success;


  // Future<void> loginApi(String username, String password) async=> store.dispatch(login(username,password));

  bool get hasError => error != null && success==null;
  bool get hasSuccess=> success != null;

  LoginScreenViewModel({
    required this.store,
    required this.loading,
    this.error,
    this.success,
  });






}

LoginScreenViewModel mapStateToProps(Store<AppState> store) {
  return LoginScreenViewModel(
    store: store,
    loading: store.state.login.loading,
    error: store.state.login.error,
    success: store.state.login.success,

  );
}


