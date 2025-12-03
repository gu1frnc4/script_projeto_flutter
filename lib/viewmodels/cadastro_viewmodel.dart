import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import '../models/usuario.dart';
import '../services/database_service.dart';

class CadastroViewModel extends ChangeNotifier {
  // Controllers
  final nomeController = TextEditingController();
  final cpfController = TextEditingController();
  final dataController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final confirmarSenhaController = TextEditingController();

  bool senhaVisivel = false;
  bool confirmarSenhaVisivel = false;

  bool carregando = false;

  // Regras de senha
  bool get temMaiuscula =>
      senhaController.text.contains(RegExp(r'[A-Z]'));
  bool get temMinuscula =>
      senhaController.text.contains(RegExp(r'[a-z]'));
  bool get temNumero =>
      senhaController.text.contains(RegExp(r'[0-9]'));
  bool get temEspecial =>
      senhaController.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));

  bool get senhaValida =>
      temMaiuscula && temMinuscula && temNumero && temEspecial;

  // Valida se nome tem nome e sobrenome
  bool get nomeCompletoValido {
    final partes = nomeController.text.trim().split(' ');
    return partes.length >= 2;
  }

  // Verifica se tudo está válido
  bool get formularioValido {
    return nomeCompletoValido &&
        cpfController.text.isNotEmpty &&
        dataController.text.isNotEmpty &&
        emailController.text.contains('@') &&
        senhaValida &&
        senhaController.text == confirmarSenhaController.text;
  }

  void alternarSenhaVisivel() {
    senhaVisivel = !senhaVisivel;
    notifyListeners();
  }

  void alternarConfirmarSenhaVisivel() {
    confirmarSenhaVisivel = !confirmarSenhaVisivel;
    notifyListeners();
  }

  String gerarHash(String senha) {
    final bytes = utf8.encode(senha);
    return sha256.convert(bytes).toString();
  }

  Future<bool> cadastrarUsuario() async {
    carregando = true;
    notifyListeners();

    final usuario = Usuario(
      nome: nomeController.text,
      cpf: cpfController.text,
      dataNascimento: dataController.text,
      email: emailController.text,
      senhaHash: gerarHash(senhaController.text),
    );

    try {
      await DatabaseService.instance.inserirUsuario(usuario);
      carregando = false;
      notifyListeners();
      return true;
    } catch (e) {
      carregando = false;
      notifyListeners();
      return false;
    }
  }
}
