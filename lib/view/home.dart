import 'package:controle_assinatura/controller/AssinaturaController.dart';
import 'package:controle_assinatura/funcionalidades/AdicionarAssinatura.dart';
import 'package:controle_assinatura/funcionalidades/EditarAssinatura.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Assinaturacontroller controller;
  bool _carregando = true;

  final TextEditingController _pesquisaController = TextEditingController();
  String _termoPesquisa = '';

  @override
  void initState() {
    super.initState();
    controller = Provider.of<Assinaturacontroller>(context, listen: false);
    carregarDados();
  }

  Future<void> carregarDados() async {
    await controller.carregarAssinaturas();
    setState(() {
      _carregando = false;
    });
  }

  void _abrirModalAdicionarAssinatura() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => AddAssinatura(),
    );
  }

  void _abrirModalEditarAssinatura(int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => EditaAssinatura(index: index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Assinaturacontroller>(
      builder: (context, controller, _) {
        final listaFiltrada = controller.assinaturas.where((assinatura) {
          return assinatura.nome
              .toLowerCase()
              .contains(_termoPesquisa.toLowerCase());
        }).toList();

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
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: TextField(
                  controller: _pesquisaController,
                  onChanged: (value) {
                    setState(() {
                      _termoPesquisa = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Pesquisar assinatura...",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          body: _carregando
              ? Center(child: CircularProgressIndicator())
              : listaFiltrada.isEmpty
                  ? Center(
                      child: Text(
                        "Nenhuma assinatura encontrada",
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                    )
                  : ListView.builder(
                      itemCount: listaFiltrada.length,
                      itemBuilder: (context, index) {
                        final assinatura = listaFiltrada[index];
                        final originalIndex = controller.assinaturas.indexOf(assinatura);
                        return Card(
                          margin:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          child: ListTile(
                            title: Text(
                              assinatura.nome,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              "Valor mensal: R\$ ${assinatura.preco.toStringAsFixed(2)}",
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () =>
                                      _abrirModalEditarAssinatura(originalIndex),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () =>
                                      controller.removerAssinatura(originalIndex),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: _abrirModalAdicionarAssinatura,
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
            items: const [
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
      },
    );
  }
}
