import 'package:firebase_core/firebase_core.dart';
// FlutterFire's Firebase Cloud Messaging plugin
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:parallel_farm/components/loading_component.dart';
import 'package:parallel_farm/constants/constants.dart';
import 'package:parallel_farm/models/eggs_data_provider.dart';
import 'package:parallel_farm/store/AppState.dart';
import 'package:parallel_farm/store/auth/api_middleware.dart';
import 'package:parallel_farm/store/reducer.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';
// TODO: Add stream controller
import 'package:rxdart/rxdart.dart';

import 'config/router.dart';
import 'firebase_options.dart';
import 'screens/splash_screen.dart';

final _messageStreamController = BehaviorSubject<RemoteMessage>();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
    print('Message data: ${message.data}');
    print('Message notification: ${message.notification?.title}');
    print('Message notification: ${message.notification?.body}');
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey =
      "pk_test_51OWduLFuVHJBya76cZkfjIjwWOPyyLLrwxw8MRfBlZG4QCPxSHFpst18fiKYvJPzghhspPbZsj2AD1WkSEB7C5FI00VoHCVCi5";
  await dotenv.load(fileName: "assets/.env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final messaging = FirebaseMessaging.instance;

  final settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (kDebugMode) {
    print('Permission granted: ${settings.authorizationStatus}');
  }
  String? token;

  token = await messaging.getToken();

  if (kDebugMode) {
    print('Registration Token=$token');
  }

  // TODO: Set up foreground message handler
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (kDebugMode) {
      print('Handling a foreground message: ${message.messageId}');
      print('Message data: ${message.data}');
      print('Message notification: ${message.notification?.title}');
      print('Message notification: ${message.notification?.body}');
    }

    _messageStreamController.sink.add(message);
  });
  // TODO: Set up background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  final store = Store<AppState>(
    reducer,
    initialState: AppState.initial(),
    middleware: [
      apiMiddleware,
    ],
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) =>
          RedeemedEggsProvider(), // Initialize your provider here
      child: PwScaffold(store: store),
    ),
  );
}

class PwScaffold extends StatelessWidget {
  final Store<AppState> store;
  const PwScaffold({
    required this.store,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child: GlobalLoaderOverlay(
            useDefaultLoading: false,
            overlayColor: accentColor.withOpacity(0.2),
            overlayWidgetBuilder: (context) {
              return const LoadingWidget();
            },
            child: MaterialApp(
              theme: ThemeData(primaryColor: primaryColor),


              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en'), // English
                Locale('sh'), // Shona
                Locale('nbl') // Ndebele
              ],
              onGenerateRoute: (settings) => generateRoute(settings),
              home: const SplashScreen(),
            )));
  }
}
