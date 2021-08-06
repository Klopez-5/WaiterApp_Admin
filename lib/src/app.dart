import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waiterapp_admin_v6/src/bloc/auth_cubit.dart';
import 'package:waiterapp_admin_v6/src/navigation/routes.dart';

final _navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  static Widget create() {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSignedOut) {
          _navigatorKey.currentState
              ?.pushNamedAndRemoveUntil(Routes.intro, (r) => false);
        } else if (state is AuthSignedIn) {
          _navigatorKey.currentState
              ?.pushNamedAndRemoveUntil(Routes.home, (r) => false);
        }
      },
      child: MyApp(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      title: 'Authentication Flow',
      //debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.routes,
    );
  }
}
