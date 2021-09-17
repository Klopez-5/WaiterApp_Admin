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
      String telefono, String direccion, String email) {
    return ListTile(
      tileColor: Color(0xFFE6E4EB),
      leading: Icon(
        Icons.account_circle,
        size: 40.0,
      ),
      title: Text(
        "$nombre $apellido",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      subtitle: Text(
        "$email",
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
            "$cedula",
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}
