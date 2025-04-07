import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/AssinaturaController.dart';

class EditaAssinatura extends StatelessWidget {
  final int index;

  EditaAssinatura({required this.index});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<Assinaturacontroller>(context, listen: false);
    final Valor = controller.assinaturas[index];

    final nameController = TextEditingController(text: Valor["name"]);
    final valueController =
        TextEditingController(text: Valor["value"].toString());

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
            "Editar Assinatura",
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

                controller.editSubscription(index, name, value);
                Navigator.pop(context);
              },
              child: Text("Salvar Alterações"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
