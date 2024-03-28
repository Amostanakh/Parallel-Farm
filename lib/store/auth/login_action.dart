import 'package:parallel_farm/apis/auth_api.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import '../AppState.dart';
import 'auth_reducer.dart';


// ThunkAction<AppState> login(username,password) => (Store<AppState> store) =>loginUser(username,password,
//         [
//           LOGIN_REQUEST,
//           LOGIN_SUCCESS,
//           LOGIN_FAILURE,
//         ],
//         store);
