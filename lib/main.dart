import 'package:controle_assinatura/view/TelaCadastro.dart';
import 'package:controle_assinatura/view/TelaFinanceiro.dart';
import 'package:controle_assinatura/view/TelaEsqueceuSenha.dart';
import 'package:controle_assinatura/view/home.dart';
import 'package:controle_assinatura/view/Telalogin.dart';
import 'package:controle_assinatura/controller/AssinaturaController.dart';
import 'package:controle_assinatura/view/TelaSobre.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(DevicePreview(
    enabled: true,
    builder: (context) => const MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Assinaturacontroller(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Controle de Assinatura",
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/tela-login',
        routes: {
          '/tela-login': (context) => LoginScreen(),
          '/tela-cadastro': (context) => TelaCadastroUsuario(),
          '/esqueceu-senha': (context) => telaEsqueceuSenha(),
          '/home': (context) => Home(),
          '/financeiro': (context) => TelaFinanceiro(),
          '/sobre': (context) => TelaSobre(),
        },
      ),
    );
  }
}
