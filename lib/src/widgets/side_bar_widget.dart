import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waiterapp_admin_v6/src/bloc/auth_cubit.dart';

class SideBarWidget extends StatelessWidget {
  const SideBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/logo.png',
                  alignment: Alignment.centerLeft,
                  width: 1210,
                  height: 100,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'WaiterApp - Admin',
                  style: const TextStyle(fontSize: 20.0),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Color(0xffF58020),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 20),
            constraints: BoxConstraints.expand(height: 80),
            child: Text(
              "Productos",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Divider(
            height: 0,
            color: Colors.black,
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 20),
            constraints: BoxConstraints.expand(height: 80),
            child: Text(
              "Ventas",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Divider(
            height: 0,
            color: Colors.black,
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 20),
            constraints: BoxConstraints.expand(height: 80),
            child: Text(
              "Clientes",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Divider(
            height: 0,
            color: Colors.black,
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 20),
            constraints: BoxConstraints.expand(height: 80),
            child: Text(
              "Empleados",
              style: TextStyle(fontSize: 18),
            ),
          ),
          Divider(
            height: 0,
            color: Colors.black,
          ),
          SizedBox(
            height: 30.0,
          ),
          Container(
            child: Column(
              children: [
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () => context.read<AuthCubit>().signOut(),
                  child: Text('Salir'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
