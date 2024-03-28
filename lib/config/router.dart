import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:parallel_farm/constants/routeConstants.dart';
import 'package:parallel_farm/models/eggs_data_provider.dart';
import 'package:parallel_farm/screens/adopt_animal_screen.dart';
import 'package:parallel_farm/screens/animal_makert_barn_screen.dart';
import 'package:parallel_farm/screens/animal_market_chickens_screen.dart';
import 'package:parallel_farm/screens/animal_screen.dart';
import 'package:parallel_farm/screens/barn_screen.dart';
import 'package:parallel_farm/screens/buy_feed_screen.dart';
import 'package:parallel_farm/screens/feed_screen.dart';
import 'package:parallel_farm/screens/forgot_password_screen.dart';
import 'package:parallel_farm/screens/friends_screen.dart';
import 'package:parallel_farm/screens/home_screen.dart';
import 'package:parallel_farm/screens/invite_screen.dart';
import 'package:parallel_farm/screens/login_screen.dart';
import 'package:parallel_farm/screens/payment_screen.dart';
import 'package:parallel_farm/screens/redeem_eggs_screen.dart';
import 'package:parallel_farm/screens/settings_screen.dart';
import 'package:parallel_farm/screens/sign_up_screen.dart';
import 'package:parallel_farm/screens/user_navigation_screen.dart';
import 'package:parallel_farm/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case SignUpScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const SignUpScreen());

    case LoginScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const LoginScreen());

    case ForgotPasswordScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const ForgotPasswordScreen());

    case BuyFeed.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const BuyFeed());

    case SettingScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const SettingScreen());

    case UserNavigationScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const UserNavigationScreen());

    case AnimalMakert.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AnimalMakert());

    case AnimalDetails.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const AnimalDetails());

    case RedemedEggsPage.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (context) => RedemedEggsPage(
          data: Provider.of<RedeemedEggsProvider>(context, listen: false).data,
        ),
      );

    case FeedsScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => FeedsScreen());

    case PwScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const PwScreen());

    case BarnPage.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const BarnPage());

    case WelcomePage.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const WelcomePage());

    case PwScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const PwScreen());

    case AnimalMarketBarnScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const AnimalMarketBarnScreen());

    case AdoptAnimal.routeName:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const AdoptAnimal(
                animalsSelected: [],
              ));

    case FriendsScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const FriendsScreen());

    case InviteScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const InviteScreen());

    case home:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const HomeScreen());

    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => Scaffold(
                appBar: AppBar(),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: SvgPicture.asset(
                          "assets/svg/not_found.svg",
                        ),
                      ),
                      const Text("Screen does not exist."),
                    ],
                  ),
                ),
              ));
  }
}
