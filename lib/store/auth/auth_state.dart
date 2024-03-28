import 'package:parallel_farm/models/token_model.dart';

class LoginState {
  bool loading;
  dynamic error;
  TokenModel? success;

  LoginState({
    required this.loading,
    this.error,
    this.success,

  });
  factory LoginState.initial() => LoginState(
    loading: false,
    error: null,
    success: null,

  );
}