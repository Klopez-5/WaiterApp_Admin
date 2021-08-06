import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waiterapp_admin_v6/src/bloc/auth_cubit.dart';

class EmailSignIn extends StatefulWidget {
  static Widget create(BuildContext context) => EmailSignIn();

  @override
  _EmailSignInState createState() => _EmailSignInState();
}

class _EmailSignInState extends State<EmailSignIn> {
  final _formKey = GlobalKey<FormState>();
  //final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? emptyValidator(String? value) {
    return (value == null || value.isEmpty) ? 'El campo es obligatorio' : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        // drawer: SideBarWidget(),
        body: BlocBuilder<AuthCubit, AuthState>(
          builder: (_, state) {
            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 75),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state is AuthSigningIn)
                      Center(child: CircularProgressIndicator()),
                    if (state is AuthError)
                      Text(
                        state.message,
                        style: TextStyle(color: Colors.red, fontSize: 24),
                      ),
                    SizedBox(height: 100),
                    Center(
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            'assets/logo.png',
                            width: 300,
                            height: 300,
                          ),
                          Text(
                            'Bienvenid@s',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 12.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 18),
                    TextFormField(
                      enabled: false,
                      // controller: _emailController,
                      decoration:
                          InputDecoration(labelText: 'admin@waiterapp.com'),
                      //validator: emptyValidator,
                    ),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(labelText: 'Contraseña'),
                      validator: emptyValidator,
                      obscureText: true,
                    ),
                    SizedBox(height: 25),
                    Center(
                      child: ElevatedButton(
                        child: const Text('Ingresar'),
                        onPressed: () {
                          if (_formKey.currentState?.validate() == true) {
                            context
                                .read<AuthCubit>()
                                .signInWithEmailAndPassword(
                                  'admin@waiterapp.com',
                                  _passwordController.text,
                                );
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 75),
                    Center(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'WaiterApp - Administración',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 12.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
