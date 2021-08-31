import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:waiterapp_admin_v6/src/widgets/side_bar_widget.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> products() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(StadistScreem());
}

double total = 0;

double sumar(double valor) {
  total = total + valor;
  return total;
}

class StadistScreem extends StatelessWidget {
  static Widget create(BuildContext context) => StadistScreem();
  final textController = TextEditingController();

  CollectionReference invoices =
      FirebaseFirestore.instance.collection('invoice');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF58020),
        centerTitle: true,
        title: Text('Estadísticas de ventas'),
      ),
      drawer: SideBarWidget(),
      backgroundColor: Colors.white,
      body: _body(),
    );
  }

  Widget _body() {
    return SafeArea(
      child: Column(
        children: <Widget>[
          _expenses(),
          _graph(),
          Container(
            color: Colors.blueAccent.withOpacity(0.15),
            height: 24.0,
          ),
          _list(),
        ],
      ),
    );
  }

//Widget para ver el total de gastos
  Widget _expenses() {
    return Column(
      children: <Widget>[
        StreamBuilder(
          stream: invoices.orderBy('day').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return Column(
              children: snapshot.data!.docs.map((invoices) {
                return Container(
                  height: 0,
                  child: Column(
                    children: <Widget>[
                      _suma(invoices['total']),
                    ],
                  ),
                );
              }).toList(),
            );
          },
        ),
        Text(
          total.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40.0,
          ),
        ),
        Text(
          "Total de ventas",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: Colors.blueGrey,
          ),
        ),
      ],
    );
  }

//Widget para cada boton inferior
  Widget _bottomAction(IconData icon) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(icon),
      ),
      onTap: () {},
    );
  }

//Widget de la grafica
  Widget _graph() {
    return Container(
      height: 250.0,
      // child: GraphWidget(),
    );
  }

//Widget de la grafica
  Widget _suma(double value) {
    total = total + value;
    return Center();
  }

  Widget _item(
      IconData icon, int day, int month, int year, int mesa, double value) {
    // total = total + value;
    return ListTile(
      leading: Icon(
        icon,
        size: 32.0,
      ),
      title: Text(
        "Factura $day/$month/$year",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      subtitle: Text(
        "Mesa: $mesa",
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
            "\$$value",
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

  Widget _list() {
    return Expanded(
      child: StreamBuilder(
        stream: invoices.orderBy('day').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return ListView(
            children: snapshot.data!.docs.map((invoices) {
              return Container(
                height: 100,
                child: Column(
                  children: <Widget>[
                    // _item(Icons.shopping_cart, "Shopping", 14, 145.12),
                    _item(
                        Icons.shopping_cart,
                        invoices['day'],
                        invoices['month'],
                        invoices['year'],
                        invoices['mesa'],
                        invoices['total']),
                    Container(
                      color: Colors.blueAccent.withOpacity(0.15),
                      height: 8.0,
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
