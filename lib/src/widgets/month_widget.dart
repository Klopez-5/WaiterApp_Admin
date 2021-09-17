import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'graph_widget.dart';

class MonthWidget extends StatefulWidget {
  //MonthWidget({Key? key}) : super(key: key);
  final List<DocumentSnapshot> documents;
  final double total;
  final List<double> perDay;
  final Map<int, double> categories;
  final Map<int, int> fecha_mes;
  final Map<int, int> fecha_anio;
  //final List<double> valores;

  MonthWidget({Key? key, required this.documents})
      : total = documents.map((doc) => doc['total']).fold(0.0, (a, b) => a + b),
        perDay = List.generate(30, (int index) {
          return documents
              .where((doc) => doc['day'] == (index + 1))
              .map((doc) => doc['total'])
              .fold(0.0, (a, b) => a + b);
        }),
        categories = documents.fold({}, (Map<int, double> map, document) {
          if (!map.containsKey(document['day'])) {
            map[document['day']] = 0.0;
          }
          map[document['day']] = (map[document['day']]! + document['total']);
          return map;
        }),
        fecha_mes = documents.fold({}, (Map<int, int> map, document) {
          map[document['day']] = document['month'];
          return map;
        }),
        fecha_anio = documents.fold({}, (Map<int, int> map, document) {
          map[document['day']] = document['year'];
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

  Widget _item(
      IconData icon, int dia, int mes, int anio, double value, double percent) {
    return ListTile(
      leading: Icon(
        icon,
        size: 32.0,
      ),
      title: Text(
        "Factura: $dia/$mes/$anio",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      subtitle: Text(
        "Representa el: ${percent.toStringAsFixed(2)}%",
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
            "\$${value.toStringAsFixed(2)}",
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
          var day = widget.categories.keys.elementAt(index);
          var data = widget.categories[day];
          var mes = widget.fecha_mes[day];
          var anio = widget.fecha_anio[day];
          return _item(Icons.shopping_cart, day, mes!, anio!, data!,
              100 * data / widget.total); //Revisar envia datos
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
