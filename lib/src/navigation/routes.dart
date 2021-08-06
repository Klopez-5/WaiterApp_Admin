import 'package:flutter/material.dart';
import 'package:waiterapp_admin_v6/src/ui/email_signin_screen.dart';
import 'package:waiterapp_admin_v6/src/ui/home_screen.dart';
//import 'package:waiterapp_admin_v6/src/ui/intro_screen.dart';
import 'package:waiterapp_admin_v6/src/ui/splash_screen.dart';

class Routes {
  static const splash = '/';
  static const intro = '/intro';
  static const products = '/products';
  //static const createAccount = '/createAccount';
  static const signInEmail = '/signInEmail';
  static const home = '/home';

  static Route routes(RouteSettings routeSettings) {
    print('Route name: ${routeSettings.name}');

    switch (routeSettings.name) {
      case splash:
        return _buildRoute(SplashScreen.create);
      case intro:
        return _buildRoute(EmailSignIn.create);
      case home:
        return _buildRoute(HomeScreen.create);
      /*case createAccount:
        return _buildRoute(EmailCreate.create);
      case products:
        return _buildRoute(IntroScreen.create);*/
      default:
        throw Exception('La ruta no existe');
    }
  }

  static MaterialPageRoute _buildRoute(Function build) =>
      MaterialPageRoute(builder: (context) => build(context));
}
