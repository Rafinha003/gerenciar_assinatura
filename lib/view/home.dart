import 'package:controle_assinatura/funcionalidades/AdicionarAssinatura.dart';
import 'package:controle_assinatura/funcionalidades/EditarAssinatura.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/AssinaturaController.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<Assinaturacontroller>(context);

    void _AbrirModalAdicionarAssinatura() {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (_) => AddAssinatura(),
      );
    }

    void _AbrirModalEditarAssinatura(int index) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (_) => EditaAssinatura(index: index),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Minhas Assinaturas"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            tooltip: "Sair",
            onPressed: () {
              Navigator.pushNamed(context, '/tela-login');
            },
          ),
        ],
      ),
      body: controller.assinaturas.isEmpty
          ? Center(
              child: Text(
                "Nenhuma assinatura cadastrada",
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            )
          : ListView.builder(
              itemCount: controller.assinaturas.length,
              itemBuilder: (context, index) {
                final subscription = controller.assinaturas[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(
                      subscription["name"],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Valor mensal: R\$ ${subscription["value"].toStringAsFixed(2)}",
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            _AbrirModalEditarAssinatura(index);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            controller.RemoverAssinatura(index);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _AbrirModalAdicionarAssinatura,
        icon: Icon(Icons.add),
        label: Text("Nova Assinatura"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.pushNamed(context, '/financeiro');
          } else if (index == 2) {
            Navigator.pushNamed(context, '/sobre');
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Início",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: "Financeiro",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: "Sobre",
          ),
        ],
      ),
    );
  }
}
