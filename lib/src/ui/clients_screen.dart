import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:waiterapp_admin_v6/src/ui/form_clients_screen.dart';
import 'package:waiterapp_admin_v6/src/widgets/side_bar_widget.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> clients() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ClientScreen());
}

class ClientScreen extends StatelessWidget {
  static Widget create(BuildContext context) => ClientScreen();
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference clients =
        FirebaseFirestore.instance.collection('client');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF58020),
        centerTitle: true,
        title: Text('Clientes'),
      ),
      drawer: SideBarWidget(),
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: StreamBuilder(
            stream: clients.orderBy('nombres').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return ListView(
                padding: EdgeInsets.only(top: 10.0, left: 10.1, right: 10.0),
                children: snapshot.data!.docs.map((clients) {
                  return Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height - 700.0,
                      child: GridView.count(
                        crossAxisCount: 1,
                        mainAxisSpacing: 0.1,
                        childAspectRatio: 0.700,
                        children: <Widget>[
                          _clienteItem(
                            clients['apellidos'],
                            clients['nombres'],
                            clients['cedula'],
                            clients['telefono'],
                            clients['direccion'],
                            clients['email'],
                          )
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
            MaterialPageRoute(builder: (context) => FormClientsScreen()),
          );
        },
        backgroundColor: Colors.orange,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _clienteItem(String nombre, String apellido, String cedula,
      int telefono, String direccion, String email) {
    return Padding(
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
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(3.0),
              ),
              Text(
                "$nombre $apellido",
                style: new TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.all(3.0),
              ),
              Text(
                cedula,
                style: new TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.all(3.0),
              ),
              Text(
                direccion,
                style: new TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.all(3.0),
              ),
              Text(
                email,
                style: new TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.all(3.0),
              ),
              Text(
                telefono.toString(),
                style: new TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
