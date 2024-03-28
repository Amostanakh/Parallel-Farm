import 'auth/auth_state.dart';

class AppState {
  final LoginState login;
  AppState({required this.login,});
  factory AppState.initial() => AppState(login: LoginState.initial());
  AppState copyWith({required LoginState login}) {
    return AppState(login:login);
}
}