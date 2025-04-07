import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Assinaturacontroller extends ChangeNotifier {
  List<Map<String, dynamic>> assinaturas = [
    {"name": "Netflix", "value": 39.90},
    {"name": "Spotify", "value": 19.90},
    {"name": "Amazon Prime", "value": 14.90},
  ];

  final Map<String, Color> _colorMap = {};

  double ObterTotalGasto() {
    return assinaturas.fold(0, (sum, item) => sum + item["value"]);
  }

  void AdicionarAssinatura(String name, double value) {
    assinaturas.add({"name": name, "value": value});
    notifyListeners();
  }

  void RemoverAssinatura(int index) {
    assinaturas.removeAt(index);
    notifyListeners();
  }

  void editSubscription(int index, String name, double value) {
    assinaturas[index] = {"name": name, "value": value};
    notifyListeners();
  }

  List<PieChartSectionData> ObterGraficoPizza() {
    return assinaturas.map((subscription) {
      return PieChartSectionData(
        value: subscription["value"],
        title: subscription["name"],
        color: ObterCorGrafico(subscription["name"]),
        radius: 50,
      );
    }).toList();
  }

  List<BarChartGroupData> ObterGraficoBarra() {
    return List.generate(assinaturas.length, (index) {
      var subscription = assinaturas[index];
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: subscription["value"],
            color: Colors.blue,
            width: 20,
          ),
        ],
      );
    });
  }

  Color ObterCorGrafico(String name) {
    if (_colorMap.containsKey(name)) {
      return _colorMap[name]!;
    }

    final Random random = Random(name.hashCode);
    final Color color = Color.fromARGB(
      255,
      random.nextInt(200) + 30,
      random.nextInt(200) + 30,
      random.nextInt(200) + 30,
    );

    _colorMap[name] = color;
    return color;
  }
}
