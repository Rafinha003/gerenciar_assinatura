import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/AssinaturaController.dart';

class ExibirGraficoBarra extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<Assinaturacontroller>(context);

    return AspectRatio(
      aspectRatio: 1.6,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: BarChart(
            BarChartData(
              barGroups: controller.ObterGraficoBarra(),
              borderData: FlBorderData(show: false),
              gridData: FlGridData(show: true),
            ),
          ),
        ),
      ),
    );
  }
}
