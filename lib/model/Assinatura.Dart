class Assinatura {
  final String id;
  final String usuarioID;
  final String nome;
  final double preco;

  Assinatura({
    required this.id,
    required this.usuarioID,
    required this.nome,
    required this.preco,
  });

  factory Assinatura.fromMap(String id, Map<String, dynamic> data) {
    return Assinatura(
      id: id,
      usuarioID: data['usuarioID'] ?? '',
      nome: data['nome'] ?? '',
      preco: (data['preco'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'usuarioID': usuarioID,
      'nome': nome,
      'preco': preco,
    };
  }
}
