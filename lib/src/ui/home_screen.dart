//import 'dart:io';

//import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:waiterapp_admin_v6/src/bloc/auth_cubit.dart';
import 'package:waiterapp_admin_v6/src/ui/clients_screen.dart';
import 'package:waiterapp_admin_v6/src/ui/products_screen.dart';
//import 'package:waiterapp_admin_v6/src/repository/auth_repository.dart';
import 'package:waiterapp_admin_v6/src/widgets/side_bar_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomeScreen extends StatelessWidget {
  //Provicional
  static Widget create(BuildContext context) => HomeScreen();
  final List<String> imageList = [
    'assets/ancas.jpg',
    'assets/ceviche.jpg',
    'assets/chontacuro.jpg',
    'assets/logo.png',
    'assets/encebollado.jpg',
    'assets/maito.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF58020),
        centerTitle: true,
        title: Text('Administración'),
      ),
      drawer: SideBarWidget(),
      backgroundColor: Colors.white,
      body: BlocBuilder<AuthCubit, AuthState>(
        buildWhen: (previous, current) => current is AuthSignedIn,
        builder: (_, state) {
          final authUser = (state as AuthSignedIn).user;
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30.0),
                Center(
                  child: CarouselSlider(
                    options: CarouselOptions(
                      enlargeCenterPage: true,
                      enableInfiniteScroll: true,
                      autoPlay: true,
                    ),
                    items: imageList
                        .map((e) => ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Stack(
                                fit: StackFit.expand,
                                children: <Widget>[
                                  Image.asset(
                                    e,
                                    width: 950,
                                    height: 400,
                                    fit: BoxFit.cover,
                                  )
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height - 105.0,
                    decoration: BoxDecoration(
                        color:
                            Colors.white, //Color del container cambiar blanco
                        borderRadius: BorderRadius.circular(10)),
                    child: ListView(
                      padding:
                          EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 25.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height - 200.0,
                            child: GridView.count(
                              crossAxisCount: 2, //Indica que es de dos columnas
                              mainAxisSpacing: 2,
                              childAspectRatio: 0.900,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(0.3),
                                  child: Container(
                                    child: new Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                      color: Colors.white,
                                      elevation: 5,
                                      child: Column(
                                        children: [
                                          Center(
                                            child: Material(
                                              child: Container(
                                                color: Colors.white,
                                                child: InkWell(
                                                  //Nos ayuda a que realize una accion como un click
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ProductScreen()),
                                                    );
                                                  },
                                                  child: Image.asset(
                                                    'assets/logo.png',
                                                    fit: BoxFit.contain,
                                                    width: 130,
                                                    height: 130,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(3.0),
                                          ),
                                          Text(
                                            'Productos',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25.0,
                                                color: Colors.green),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(0.3),
                                  child: Container(
                                    child: new Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                      color: Colors.white,
                                      elevation: 5,
                                      child: Column(
                                        children: [
                                          Center(
                                            child: Material(
                                              child: Container(
                                                color: Colors.white,
                                                child: InkWell(
                                                  //Nos ayuda a que realize una accion como un click
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ProductScreen()),
                                                    );
                                                  },
                                                  child: Image.asset(
                                                    'assets/logo.png',
                                                    fit: BoxFit.contain,
                                                    width: 130,
                                                    height: 130,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(3.0),
                                          ),
                                          Text(
                                            'Ventas',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25.0,
                                                color: Colors.green),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(0.3),
                                  child: Container(
                                    child: new Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                      color: Colors.white,
                                      elevation: 5,
                                      child: Column(
                                        children: [
                                          Center(
                                            child: Material(
                                              child: Container(
                                                color: Colors.white,
                                                child: InkWell(
                                                  //Nos ayuda a que realize una accion como un click
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ClientScreen()),
                                                    );
                                                  },
                                                  child: Image.asset(
                                                    'assets/logo.png',
                                                    fit: BoxFit.contain,
                                                    width: 130,
                                                    height: 130,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(3.0),
                                          ),
                                          Text(
                                            'Clientes',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25.0,
                                                color: Colors.green),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(0.3),
                                  child: Container(
                                    child: new Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0)),
                                      color: Colors.white,
                                      elevation: 5,
                                      child: Column(
                                        children: [
                                          Center(
                                            child: Material(
                                              child: Container(
                                                color: Colors.white,
                                                child: InkWell(
                                                  //Nos ayuda a que realize una accion como un click
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ProductScreen()),
                                                    );
                                                  },
                                                  child: Image.asset(
                                                    'assets/logo.png',
                                                    fit: BoxFit.contain,
                                                    width: 130,
                                                    height: 130,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(3.0),
                                          ),
                                          Text(
                                            'Empleados',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25.0,
                                                color: Colors.green),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                //AQUI HAY UN ERROR
                                /* _mesasItem(
                                    'Productos', 'assets/logo.png', 'products'),
                                _mesasItem(
                                    'Ventas', 'assets/logo.png', 'ventas'),
                                _mesasItem(
                                    'Clientes', 'assets/logo.png', 'clientes'),
                                _mesasItem('Empleados', 'assets/logo.png',
                                    'empleados'),*/
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Text('Usuario: ${authUser.uid}'),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _mesasItem(String numero, String imagen, String ruta) {
    return Padding(
      padding: EdgeInsets.all(0.3),
      child: Container(
        child: new Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          color: Colors.white,
          elevation: 5,
          child: Column(
            children: [
              Hero(
                tag: imagen,
                child: Material(
                  child: Container(
                    color: Colors.white,
                    child: InkWell(
                      //Nos ayuda a que realize una accion como un click
                      onTap: () => null,
                      child: Image.asset(
                        imagen,
                        fit: BoxFit.contain,
                        width: 130,
                        height: 130,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(3.0),
              ),
              Text(
                numero,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                    color: Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
