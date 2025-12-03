import 'package:flutter/material.dart';

class TelaResultados extends StatelessWidget {
  final String texto;

  const TelaResultados({super.key, required this.texto});

  @override
  Widget build(BuildContext context) {
    final quantidadeCaracteres = texto.length;
    final quantidadePalavras = texto.trim().isEmpty
        ? 0
        : texto.trim().split(RegExp(r'\s+')).length;

    return Scaffold(
      appBar: AppBar(title: const Text("Resultados da Análise")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Texto analisado:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Text(
              texto,
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),

            Text(
              "Quantidade de caracteres: $quantidadeCaracteres",
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              "Quantidade de palavras: $quantidadePalavras",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
