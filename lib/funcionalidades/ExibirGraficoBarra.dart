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
          padding: const EdgeInsets.all(16.0),
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              barTouchData: BarTouchData(
                enabled: true,
                touchTooltipData: BarTouchTooltipData(
                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                    final assinatura = controller.assinaturas[group.x.toInt()];
                    return BarTooltipItem(
                      '${assinatura.nome}\nR\$ ${rod.toY.toStringAsFixed(2)}',
                      TextStyle(color: Colors.white),
                    );
                  },
                ),
              ),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      final assinatura = controller.assinaturas[value.toInt()];
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          assinatura.nome,
                          style: TextStyle(fontSize: 12),
                        ),
                      );
                    },
                    reservedSize: 42,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 10,
                    getTitlesWidget: (value, meta) => Text('R\$ ${value.toInt()}'),
                    reservedSize: 40,
                  ),
                ),
                topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(show: false),
              gridData: FlGridData(
                show: true,
                drawHorizontalLine: true,
                horizontalInterval: 10,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: Colors.grey[300],
                  strokeWidth: 1,
                ),
              ),
              barGroups: controller.obterGraficoBarra(),
            ),
          ),
        ),
      ),
    );
  }
}
