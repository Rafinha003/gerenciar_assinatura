import 'package:controle_assinatura/controller/SubscriptionController.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FinanceiroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SubscriptionController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Financeiro"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Gasto por Mês",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "R\$ ${controller.getTotalGasto().toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),

            Text(
              "Distribuição dos Gastos",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            AspectRatio(
              aspectRatio: 1.4,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: PieChart(
                    PieChartData(
                      sections: controller.getSubscriptionPieChartData(),
                      centerSpaceRadius: 40,
                      sectionsSpace: 3,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 24),

            Text(
              "Gastos por Categoria",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            AspectRatio(
              aspectRatio: 1.6,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: BarChart(
                    BarChartData(
                      barGroups: controller.getSubscriptionBarChartData(),
                      borderData: FlBorderData(show: false),
                      gridData: FlGridData(show: true),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
