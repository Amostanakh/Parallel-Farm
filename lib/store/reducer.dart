

import 'AppState.dart';
import 'auth/auth_reducer.dart';

AppState reducer(AppState state, action) {
  return AppState(
    login:loginReducer(state.login, action),

  );
}