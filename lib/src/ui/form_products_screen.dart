import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:waiterapp_admin_v6/src/widgets/side_bar_widget.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> products() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FormProductScreen());
}

class FormProductScreen extends StatelessWidget {
  static Widget create(BuildContext context) => FormProductScreen();
  final _formKey = GlobalKey<FormState>();
  final nombreController = TextEditingController();
  final precioController = TextEditingController();
  final descripcionController = TextEditingController();
  final categoriaController = TextEditingController();

  String? emptyValidator(String? value) {
    return (value == null || value.isEmpty) ? 'El campo es obligatorio' : null;
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference productos =
        FirebaseFirestore.instance.collection('productos');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF58020),
        centerTitle: true,
        title: Text('Producto'),
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
                          'assets/add_2.png',
                          width: 300,
                          height: 300,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 18),
                  TextFormField(
                    controller: nombreController,
                    decoration: InputDecoration(labelText: 'Nombre'),
                    validator: emptyValidator,
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: descripcionController,
                    decoration: InputDecoration(labelText: 'Descripción'),
                    validator: emptyValidator,
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: precioController,
                    decoration: InputDecoration(labelText: 'Precio'),
                    validator: emptyValidator,
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: categoriaController,
                    decoration: InputDecoration(labelText: 'Categoria'),
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
            productos.add({
              'nombre': nombreController.text,
              'descripcion': descripcionController.text,
              'precio': precioController.text,
              'categoria': categoriaController.text,
              'imagen': '-----',
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
