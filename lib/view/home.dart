import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/SubscriptionController.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SubscriptionController>(context);

    void _showSubscriptionModal({bool isEdit = false, int? index}) {
      final nameController = TextEditingController(
        text: isEdit ? controller.subscriptions[index!]["name"] : '',
      );
      final valueController = TextEditingController(
        text: isEdit ? controller.subscriptions[index!]["value"].toString() : '',
      );

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
                  isEdit ? "Editar Assinatura" : "Nova Assinatura",
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
                    labelText: "Valor mensal (R\$)",
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
                      final name = nameController.text.trim();
                      final value = double.tryParse(valueController.text) ?? 0;

                      if (name.isEmpty || value <= 0) return;

                      if (isEdit && index != null) {
                        controller.editSubscription(index, name, value);
                      } else {
                        controller.addSubscription(name, value);
                      }

                      Navigator.pop(context);
                    },
                    child: Text(isEdit ? "Salvar Alterações" : "Salvar"),
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
                            _showSubscriptionModal(isEdit: true, index: index);
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
        onPressed: () => _showSubscriptionModal(),
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
