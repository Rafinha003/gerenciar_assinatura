import 'package:controle_assinatura/controller/SubscriptionController.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SubscriptionController>(context);

    void _showAddSubscriptionModal(BuildContext context) {
      TextEditingController nameController = TextEditingController();
      TextEditingController valueController = TextEditingController();

      showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 24,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Nova Assinatura",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Nome da Assinatura",
                    prefixIcon: Icon(Icons.subscriptions),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: valueController,
                  decoration: InputDecoration(
                    labelText: "Valor (R\$)",
                    prefixIcon: Icon(Icons.attach_money),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.addSubscription(
                        nameController.text,
                        double.tryParse(valueController.text) ?? 0,
                      );
                      Navigator.pop(context);
                    },
                    child: Text("Salvar"),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
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
      body: controller.subscriptions.isEmpty
          ? Center(
              child: Text(
                "Nenhuma assinatura cadastrada",
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            )
          : ListView.builder(
              itemCount: controller.subscriptions.length,
              itemBuilder: (context, index) {
                final subscription = controller.subscriptions[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(
                      subscription["name"]!,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "Valor: R\$ ${subscription["value"].toStringAsFixed(2)}",
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () {
                            // lógica de edição pode ser implementada aqui
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            controller.removeSubscription(index);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddSubscriptionModal(context),
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
