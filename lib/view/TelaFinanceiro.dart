import 'package:controle_assinatura/funcionalidades/ExibirCardValorTotal.dart';
import 'package:controle_assinatura/funcionalidades/ExibirGraficoBarra.dart';
import 'package:controle_assinatura/funcionalidades/ExibirGraficoPizza.dart';
import 'package:flutter/material.dart';

class TelaFinanceiro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            ExibirCardValortotal(),
            SizedBox(height: 24),
            Text(
              "Distribuição dos Gastos",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            ExibirGraficoPizza(),
            SizedBox(height: 24),
            Text(
              "Gastos por Categoria",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            ExibirGraficoBarra(),
          ],
        ),
      ),
    );
  }
}
