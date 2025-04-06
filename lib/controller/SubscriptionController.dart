import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SubscriptionController extends ChangeNotifier {
  List<Map<String, dynamic>> subscriptions = [
    {"name": "Netflix", "value": 39.90},
    {"name": "Spotify", "value": 19.90},
    {"name": "Amazon Prime", "value": 14.90},
  ];

   final Map<String, Color> _colorMap = {};

  double getTotalGasto() {
    return subscriptions.fold(0, (sum, item) => sum + item["value"]);
  }

  void addSubscription(String name, double value) {
    subscriptions.add({"name": name, "value": value});
    notifyListeners(); 
  }

  void removeSubscription(int index) {
    subscriptions.removeAt(index);
    notifyListeners(); 
  }

  void editSubscription(int index, String name, double value) {
    subscriptions[index] = {"name": name, "value": value};
    notifyListeners(); 
  }

  List<PieChartSectionData> getSubscriptionPieChartData() {
    return subscriptions.map((subscription) {
      return PieChartSectionData(
        value: subscription["value"],
        title: subscription["name"],
        color: _getColorForSubscription(subscription["name"]),
        radius: 50,
      );
    }).toList();
  }

  List<BarChartGroupData> getSubscriptionBarChartData() {
    return List.generate(subscriptions.length, (index) {
      var subscription = subscriptions[index];
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

 Color _getColorForSubscription(String name) {
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
