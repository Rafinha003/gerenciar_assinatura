import 'package:controle_assinatura/controller/AutenticacaoController.dart';
import 'package:flutter/material.dart';

class telaEsqueceuSenha extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();

   AutenticacaoController _autenticacaoController = AutenticacaoController();

  @override
  Widget build(BuildContext context) {

       btnEnviar() {
    String email = _emailController.text;

    _autenticacaoController.RecuperarSenha(email: email).then((String? erro) {
      if (erro != null) {
         ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(erro)), );
      } else {

        Navigator.pushNamed(context,  '/tela-login');
      }
    });
  }

    return Scaffold(
      appBar: AppBar(
        title: Text("Recuperar Senha"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 6,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.lock_reset, size: 64, color: Colors.blue),
                  SizedBox(height: 16),
                  Text(
                    "Esqueceu sua senha?",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Digite seu e-mail e enviaremos instruções para redefinir sua senha.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                  ),
                  SizedBox(height: 24),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: "E-mail",
                      prefixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text("Instruções enviadas para o e-mail.")),
                        );
                        btnEnviar();
                      },
                      icon: Icon(Icons.send),
                      label: Text("Recuperar Senha"),

                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        textStyle: TextStyle(fontSize: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Voltar para o login"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
