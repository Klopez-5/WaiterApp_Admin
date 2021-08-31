import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'graph_widget.dart';

class MonthWidget extends StatefulWidget {
  //MonthWidget({Key? key}) : super(key: key);
  final List<DocumentSnapshot> documents;
  final double total;
  final List<double> perDay;
  final Map<String, double> categories;
  final Map<String, double> mesas;
  //final List<double> valores;

  MonthWidget({Key? key, required this.documents})
      : total = documents.map((doc) => doc['total']).fold(0.0, (a, b) => a + b),
        perDay = List.generate(30, (int index) {
          return documents
              .where((doc) => doc['day'] == (index + 1))
              .map((doc) => doc['total'])
              .fold(0.0, (a, b) => a + b);
        }),
        categories = documents.fold({}, (Map<String, double> map, document) {
          if (!map.containsKey(document['id_client'])) {
            map[document['id_client']] = 0.0;
          }
          map[document['id_client']] = document['total'];
          return map;
        }),
        mesas = documents.fold({}, (Map<String, double> map, document) {
          if (!map.containsKey(document['mesa'])) {
            map[document['mesa']] = 0.0;
          }
          map[document['mesa']] = document['total'];
          return map;
        }),
        //valores = documents.where((doc) => doc['day']).map((doc) => doc['total'])),
        super(key: key);

  @override
  _MonthWidgetState createState() => _MonthWidgetState();
}

class _MonthWidgetState extends State<MonthWidget> {
  @override
  Widget build(BuildContext context) {
    print(widget.categories);
    return Expanded(
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

  Widget _expenses() {
    return Column(
      children: <Widget>[
        Text(
          "\$${widget.total.toStringAsFixed(2)}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40.0,
          ),
        ),
        Text(
          "Total de ventas del mes",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: Colors.blueGrey,
          ),
        ),
      ],
    );
  }

  Widget _graph() {
    return Container(
      height: 250.0,
      child: GraphWidget(
        data: widget.perDay,
      ),
    );
  }

  Widget _item(IconData icon, String name, String mesa, double value) {
    return ListTile(
      leading: Icon(
        icon,
        size: 32.0,
      ),
      title: Text(
        "Factura: 00/08/2021",
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
      child: ListView.separated(
        itemCount: widget.categories.keys.length,
        itemBuilder: (BuildContext context, int index) {
          var key = widget.categories.keys.elementAt(index);
          var mesak = widget.mesas.keys.elementAt(index);
          var data = widget.categories[key];
          //var day1 = widget.mesas[key];
          return _item(
              Icons.shopping_cart, key, mesak, data!); //Revisar envia datos
        },
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            color: Colors.blueAccent.withOpacity(0.15),
            height: 8.0,
          );
        },
      ),
    );
  }
}
