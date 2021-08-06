import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:waiterapp_admin_v6/src/widgets/side_bar_widget.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> clients() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FormClientsScreen());
}

class FormClientsScreen extends StatelessWidget {
  static Widget create(BuildContext context) => FormClientsScreen();
  final _formKey = GlobalKey<FormState>();
  final nombreController = TextEditingController();
  final apellidoController = TextEditingController();
  final cedulaController = TextEditingController();
  final direccionController = TextEditingController();
  final celularController = TextEditingController();
  final emailController = TextEditingController();

  String? emptyValidator(String? value) {
    return (value == null || value.isEmpty) ? 'El campo es obligatorio' : null;
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference clients =
        FirebaseFirestore.instance.collection('client');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF58020),
        centerTitle: true,
        title: Text('Cliente'),
      ),
      drawer: SideBarWidget(),
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 75),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'assets/add_3.png',
                          width: 300,
                          height: 300,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: cedulaController,
                    decoration: InputDecoration(labelText: 'Cédula'),
                    validator: emptyValidator,
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: nombreController,
                    decoration: InputDecoration(labelText: 'Nombres'),
                    validator: emptyValidator,
                  ),
                  SizedBox(height: 18),
                  TextFormField(
                    controller: apellidoController,
                    decoration: InputDecoration(labelText: 'Apellidos'),
                    validator: emptyValidator,
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: direccionController,
                    decoration: InputDecoration(labelText: 'Dirección'),
                    validator: emptyValidator,
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: celularController,
                    decoration: InputDecoration(labelText: 'Telefono'),
                    validator: emptyValidator,
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    validator: emptyValidator,
                  ),
                  SizedBox(height: 70),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_formKey.currentState?.validate() == true) {
            clients.add({
              'nombres': nombreController.text,
              'apellidos': apellidoController.text,
              'cedula': cedulaController.text,
              'direccion': direccionController.text,
              'email': emailController.text,
              'telefono': celularController.text,
            });
            Navigator.pop(context);
          }
        },
        backgroundColor: Colors.orange,
        child: Icon(Icons.save),
      ),
    );
  }
}
