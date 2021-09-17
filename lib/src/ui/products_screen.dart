import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:waiterapp_admin_v6/src/ui/form_products_screen.dart';
import 'package:waiterapp_admin_v6/src/widgets/side_bar_widget.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> products() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProductScreen());
}

class ProductScreen extends StatelessWidget {
  static Widget create(BuildContext context) => ProductScreen();
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference productos =
        FirebaseFirestore.instance.collection('productos');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF58020),
        centerTitle: true,
        title: Text('Productos'),
      ),
      drawer: SideBarWidget(),
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: StreamBuilder(
            stream: productos.orderBy('nombre').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return ListView(
                padding: EdgeInsets.only(top: 10.0, left: 10.1, right: 10.0),
                children: snapshot.data!.docs.map((productos) {
                  return Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height - 700.0,
                      child: GridView.count(
                        crossAxisCount: 1,
                        mainAxisSpacing: 0.1,
                        childAspectRatio: 0.700,
                        children: <Widget>[
                          _productoItem(productos['nombre'],
                              productos['cantidad'], 'assets/add_1.png'),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FormProductScreen()),
          );
        },
        backgroundColor: Colors.orange,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _productoItem(String nombre, int cantidad, String imagen) {
    return ListTile(
      leading: Icon(
        Icons.view_in_ar_rounded,
        size: 32.0,
      ),
      title: Text(
        "$nombre",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      subtitle: Text(
        "Cantidad: $cantidad",
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.blueGrey,
        ),
      ),
      trailing: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent.withOpacity(0.2),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "\$$cantidad",
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );

    /*return Padding(
      padding: EdgeInsets.all(3.0),
      child: Container(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          color: Color(0xFFE6E4EB),
          elevation: 4,
          child: Column(
            children: <Widget>[
              Center(
                child: Material(
                  child: Container(
                    color: Color(0xFFE6E4EB),
                    /* child: InkWell(
                        onTap: () => Navigator.of(context).push(
                            new MaterialPageRoute(
                                builder: (context) => FormProductScreen(
                                    nombre: nombre,
                                    precio: precio,
                                    imagen: imagen))),*/
                    child: new Image.asset(
                      imagen,
                      fit: BoxFit.contain,
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(3.0),
              ),
              Text(
                nombre,
                style: new TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.all(3.0),
              ),
              Text(
                "\$$cantidad",
                style: new TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );*/
  }
}
