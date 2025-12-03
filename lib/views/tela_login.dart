import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/login_viewmodel.dart';
import 'tela_cadastro.dart';
import 'tela_principal.dart';

class TelaLogin extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  TelaLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<LoginViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: vm.emailController,
                decoration: const InputDecoration(labelText: "E-mail"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Digite o e-mail";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 12),

              TextFormField(
                controller: vm.senhaController,
                obscureText: true,
                decoration: const InputDecoration(labelText: "Senha"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Digite a senha";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              if (vm.erroMensagem != null)
                Text(
                  vm.erroMensagem!,
                  style: const TextStyle(color: Colors.red),
                ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    final sucesso = await vm.fazerLogin();

                    if (sucesso) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => TelaPrincipal(
                            nomeUsuario: vm.emailController.text,
                          ),
                        ),
                      );
                    }
                  }
                },
                child: vm.carregando
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Entrar"),
              ),

              const SizedBox(height: 20),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => TelaCadastro()),
                  );
                },
                child: const Text("Ainda não tem conta? Cadastre-se"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
