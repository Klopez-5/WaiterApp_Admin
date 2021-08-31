import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class ChartYearScreen extends StatefulWidget {
  //const ChartYearScreen({Key? key}) : super(key: key);
  @override
  _ChartYearScreenState createState() => _ChartYearScreenState();
}

class _ChartYearScreenState extends State<ChartYearScreen> {
  late List<SalesData> _chartData;

  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    super.initState();
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xffF58020),
              centerTitle: true,
              title: Text('Estadísticas de ventas por año'),
            ),
            body: SfCartesianChart(
              title: ChartTitle(text: 'Analisis de ventas'),
              legend: Legend(isVisible: true),
              tooltipBehavior: _tooltipBehavior,
              series: <SplineSeries>[
                SplineSeries<SalesData, double>(
                    name: 'Ventas',
                    dataSource: _chartData,
                    xValueMapper: (SalesData sales, _) => sales.year,
                    yValueMapper: (SalesData sales, _) => sales.sales,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                    enableTooltip: true,
                    color: Colors.orange,
                    width: 4,
                    opacity: 1,
                    dashArray: <double>[5, 5],
                    splineType: SplineType.cardinal,
                    cardinalSplineTension: 0.9)
              ],
              primaryXAxis: NumericAxis(
                edgeLabelPlacement: EdgeLabelPlacement.shift,
              ),
              primaryYAxis: NumericAxis(
                  labelFormat: '{value}M',
                  numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0)),
            )));
  }
}

List<SalesData> getChartData() {
  final List<SalesData> chartData = [
    SalesData(2017, 180),
    SalesData(2018, 12),
    SalesData(2019, 24),
    SalesData(2020, 18),
    SalesData(2021, 30)
  ];
  return chartData;
}

class SalesData {
  SalesData(this.year, this.sales);
  final double year;
  final double sales;
}
