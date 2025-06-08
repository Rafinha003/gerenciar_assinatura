import 'dart:core';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:controle_assinatura/model/Assinatura.Dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Assinaturacontroller extends ChangeNotifier {
  List<Assinatura> _assinaturas = [];
  List<Assinatura> _assinaturasFiltradas = [];

  List<Assinatura> get assinaturas => _assinaturasFiltradas.isEmpty ? _assinaturas : _assinaturasFiltradas;
  
  final CollectionReference _colecao = FirebaseFirestore.instance.collection('assinaturas');
  final String? _usuarioID = FirebaseAuth.instance.currentUser?.uid;

    AssinaturaController() {
    carregarAssinaturas();
  }

  Future<void> carregarAssinaturas() async {
    if (_usuarioID == null) return;

    final snapshot = await _colecao
        .where('usuarioID', isEqualTo: _usuarioID)
        .get();

    _assinaturas = snapshot.docs.map((doc) {
      return Assinatura.fromMap(doc.id, doc.data() as Map<String, dynamic>);
    }).toList();

    _assinaturasFiltradas.clear(); 
    notifyListeners();
  }

    void pesquisarAssinaturas(String termo) {
    if (termo.isEmpty) {
      _assinaturasFiltradas.clear();
    } else {
      _assinaturasFiltradas = _assinaturas
          .where((a) => a.nome.toLowerCase().contains(termo.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  double ObterTotalGasto() {
    return _assinaturas.fold(0.0, (sum, item) => sum + item.preco);
  }

    Future<void> adicionarAssinatura(String nome, double preco, String usuarioID) async {
    final doc = await _colecao.add({'nome': nome, 'preco': preco, 'usuarioID': usuarioID});
    _assinaturas.add(Assinatura(id: doc.id, nome: nome, preco: preco, usuarioID: usuarioID));
    notifyListeners();
  }

  Future<void> removerAssinatura(int index) async {
    await _colecao.doc(_assinaturas[index].id).delete();
    _assinaturas.removeAt(index);
    notifyListeners();
  }

  Future<void> editarAssinatura(int index, String nome, double preco, String usuarioID) async {
    final id = _assinaturas[index].id;
    await _colecao.doc(id).update({'nome': nome, 'preco': preco, 'usuarioID': usuarioID});
    _assinaturas[index] = Assinatura(id: id, nome: nome, preco: preco, usuarioID: usuarioID);
    notifyListeners();
  }

  List<PieChartSectionData> obterGraficoPizza() {
    return _assinaturas.map((assinatura) {
      return PieChartSectionData(
        value: assinatura.preco,
        title: assinatura.nome,
        color: obterCorGrafico(assinatura.nome),
        radius: 50,
      );
    }).toList();
  }

    final Map<String, Color> _colorMap = {};



List<BarChartGroupData> obterGraficoBarra() {
  return List.generate(_assinaturas.length, (index) {
    final assinatura = _assinaturas[index];
    return BarChartGroupData(
      x: index,
      barRods: [
        BarChartRodData(
          toY: assinatura.preco,
          gradient: LinearGradient(
            colors: [Colors.blue.shade300, Colors.blue.shade700],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
          width: 22,
          borderRadius: BorderRadius.circular(8),
        ),
      ],
      showingTooltipIndicators: [0],
    );
  });
}



  Color obterCorGrafico(String nome) {
    if (_colorMap.containsKey(nome)) {
      return _colorMap[nome]!;
    }

    final random = Random(nome.hashCode);
    final color = Color.fromARGB(
      255,
      random.nextInt(200) + 30,
      random.nextInt(200) + 30,
      random.nextInt(200) + 30,
    );

    _colorMap[nome] = color;
    return color;
  }
}
