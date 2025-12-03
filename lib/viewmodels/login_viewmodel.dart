import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import '../services/database_service.dart';

class LoginViewModel extends ChangeNotifier {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  bool carregando = false;
  String? erroMensagem;

  String gerarHash(String senha) {
    final bytes = utf8.encode(senha);
    return sha256.convert(bytes).toString();
  }

  Future<bool> fazerLogin() async {
    carregando = true;
    notifyListeners();

    final email = emailController.text.trim();
    final senhaHash = gerarHash(senhaController.text);

    final usuario =
        await DatabaseService.instance.buscarUsuarioPorEmail(email);

    if (usuario == null) {
      erroMensagem = "E-mail não encontrado";
      carregando = false;
      notifyListeners();
      return false;
    }

    if (usuario.senhaHash != senhaHash) {
      erroMensagem = "Senha incorreta";
      carregando = false;
      notifyListeners();
      return false;
    }

    erroMensagem = null;
    carregando = false;
    notifyListeners();
    return true;
  }
}
