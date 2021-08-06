import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waiterapp_admin_v6/src/bloc/auth_cubit.dart';
import 'package:waiterapp_admin_v6/src/navigation/routes.dart';

class IntroScreen extends StatelessWidget {
  static Widget create(BuildContext context) => IntroScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //    title: const Text('Bienvenido'),
      //  ),
      body: _LoginPage(),
    );
  }
}

class _LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authCubit = context.watch<AuthCubit>();
    final isSigningIn = authCubit.state is AuthSigningIn;

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 150.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/logo.png',
            width: 200,
            height: 200,
          ),
          SizedBox(height: 150),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Column(
              children: [
                SizedBox(height: 48),
                OutlinedButton(
                  child: Text('Ingresar'),
                  onPressed: () {
                    authCubit.reset();
                    Navigator.pushNamed(context, Routes.signInEmail);
                  },
                ),
                SizedBox(height: 48),
              ],
            ),
          ),
          SizedBox(height: 25),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                'WaiterApp - Administración',
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 12.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          if (isSigningIn) CircularProgressIndicator(),
        ],
      ),
    );
  }
}
