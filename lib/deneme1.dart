import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartData {
  final String label;
  final double value;

  ChartData(this.label, this.value);
}

class PieChartWidget extends StatelessWidget {
  final List<ChartData> data;

  PieChartWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      series: <CircularSeries>[
        PieSeries<ChartData, String>(
          dataSource: data,
          xValueMapper: (ChartData chartData, _) => chartData.label,
          yValueMapper: (ChartData chartData, _) => chartData.value,
          dataLabelSettings: DataLabelSettings(isVisible: true),
        )
      ],
    );
  }
}
