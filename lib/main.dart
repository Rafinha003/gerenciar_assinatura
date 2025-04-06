import 'package:controle_assinatura/view/Cadastro.dart';
import 'package:controle_assinatura/view/Financeiro.dart';
import 'package:controle_assinatura/view/esqueceuSenha.dart';
import 'package:controle_assinatura/view/home.dart';
import 'package:controle_assinatura/view/login.dart';
import 'package:controle_assinatura/controller/SubscriptionController.dart';
import 'package:controle_assinatura/view/sobre.dart';
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
      create: (_) => SubscriptionController(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Controle de Assinatura",
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/tela-login',
        routes: {
          '/tela-login': (context) => LoginScreen(),
          '/tela-cadastro': (context) => CadastroUsuarioScreen(),
          '/esqueceu-senha': (context) => EsqueceuSenhaScreen(),
          '/home': (context) => HomeScreen(),
          '/financeiro': (context) => FinanceiroScreen(),
          '/sobre': (context) => SobreScreen(),
        },
      ),
    );
  }
}
