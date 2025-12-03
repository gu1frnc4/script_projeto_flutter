class Usuario {
  final int? id;
  final String nome;
  final String cpf;
  final String dataNascimento;
  final String email;
  final String senhaHash;

  Usuario({
    this.id,
    required this.nome,
    required this.cpf,
    required this.dataNascimento,
    required this.email,
    required this.senhaHash,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'cpf': cpf,
      'dataNascimento': dataNascimento,
      'email': email,
      'senhaHash': senhaHash,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map['id'],
      nome: map['nome'],
      cpf: map['cpf'],
      dataNascimento: map['dataNascimento'],
      email: map['email'],
      senhaHash: map['senhaHash'],
    );
  }
}
