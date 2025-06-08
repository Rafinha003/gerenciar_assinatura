import 'package:controle_assinatura/controller/AutenticacaoController.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

   AutenticacaoController _autenticacaoController = AutenticacaoController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gerencie suas assinaturas")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.lock_outline, size: 80, color: Colors.blueAccent),
                SizedBox(height: 16),
                Text(
                  "Seja bem vindo!",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 32),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "E-mail",
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Digite um e-mail";
                    }
                    if (!RegExp(r"^[\w\.-]+@[\w\.-]+\.\w+$").hasMatch(value)) {
                      return "E-mail inválido";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _senhaController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Senha",
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Digite sua senha";
                    }
                    if (value.length < 6) {
                      return "A senha deve ter pelo menos 6 caracteres";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _validateAndLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      textStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                    ),
                    child: Text("Entrar"),
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/tela-cadastro');
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.blueAccent),
                      foregroundColor: Colors.blueAccent,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text("Cadastrar Usuário"),
                  ),
                ),
                SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/esqueceu-senha');
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey[700],
                    textStyle: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  child: Text("Esqueceu a senha?"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  void _validateAndLogin() {
    String email = _emailController.text;
    String senha = _senhaController.text;

    if (_formKey.currentState!.validate()) {
        _autenticacaoController.LogarUsuario(email: email, senha: senha).then((String? erro){
          if(erro != null){
             ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(erro)),
      );
          } else{
             ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Seja bem vindo")));
             Navigator.pushNamed(context, '/home');
          }
        });
      } else{
           ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Há um ou mais campos inválidos!")),
      );
       }
    }
  }

