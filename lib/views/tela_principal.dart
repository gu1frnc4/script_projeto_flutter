import 'package:flutter/material.dart';
import 'tela_resultados.dart';

class TelaPrincipal extends StatefulWidget {
  final String nomeUsuario;

  const TelaPrincipal({super.key, required this.nomeUsuario});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  final textoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Analisador de Texto"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Bem-vindo, ${widget.nomeUsuario}!",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Digite um texto para analisar:",
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: textoController,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Digite algo aqui...",
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                if (textoController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Digite algum texto")),
                  );
                  return;
                }

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TelaResultados(
                      texto: textoController.text,
                    ),
                  ),
                );
              },
              child: const Text("Analisar"),
            ),
          ],
        ),
      ),
    );
  }
}
