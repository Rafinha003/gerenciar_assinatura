import 'package:flutter/material.dart';

class CadastroUsuarioScreen extends StatefulWidget {
  @override
  _CadastroUsuarioScreenState createState() => _CadastroUsuarioScreenState();
}

class _CadastroUsuarioScreenState extends State<CadastroUsuarioScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmarSenhaController = TextEditingController();

  void _salvarUsuario() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Usuário cadastrado com sucesso!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastrar Usuário")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.person_add_alt_1, size: 80, color: Colors.blueAccent),
                  SizedBox(height: 16),
                  Text(
                    "Crie sua conta",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 32),

                  TextFormField(
                    controller: _nomeController,
                    decoration: InputDecoration(
                      labelText: "Nome",
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Digite o nome";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),

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
                        return "Digite o e-mail";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),

                  TextFormField(
                    controller: _telefoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: "Número de Telefone",
                      prefixIcon: Icon(Icons.phone),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Digite o número de telefone";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),

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
                        return "Digite a senha";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),

                  TextFormField(
                    controller: _confirmarSenhaController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Confirmar Senha",
                      prefixIcon: Icon(Icons.lock_outline),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Confirme a senha";
                      }
                      if (value != _senhaController.text) {
                        return "As senhas não coincidem";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _salvarUsuario,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                      ),
                      child: Text("Salvar"),
                    ),
                  ),
                  SizedBox(height: 12),

                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.grey[700],
                      textStyle: TextStyle(decoration: TextDecoration.underline),
                    ),
                    child: Text("Cancelar"),
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
