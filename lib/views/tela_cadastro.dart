import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/cadastro_viewmodel.dart';

class TelaCadastro extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  TelaCadastro({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<CadastroViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Cadastro de Usuário")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              // NOME COMPLETO
              TextFormField(
                controller: vm.nomeController,
                decoration: const InputDecoration(labelText: "Nome completo"),
                validator: (value) {
                  if (!vm.nomeCompletoValido) {
                    return "Digite nome e sobrenome";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 12),

              // CPF
              TextFormField(
                controller: vm.cpfController,
                decoration: const InputDecoration(labelText: "CPF"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "CPF obrigatório";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 12),

              // DATA DE NASCIMENTO
              TextFormField(
                controller: vm.dataController,
                decoration: const InputDecoration(labelText: "Data de nascimento"),
                readOnly: true,
                onTap: () async {
                  final data = await showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                    initialDate: DateTime(2000),
                  );
                  if (data != null) {
                    vm.dataController.text =
                        "${data.day}/${data.month}/${data.year}";
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Data obrigatória";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 12),

              // EMAIL
              TextFormField(
                controller: vm.emailController,
                decoration: const InputDecoration(labelText: "E-mail"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "E-mail obrigatório";
                  }
                  if (!value.contains('@')) {
                    return "E-mail inválido";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 12),

              // SENHA
              TextFormField(
                controller: vm.senhaController,
                obscureText: !vm.senhaVisivel,
                decoration: InputDecoration(
                  labelText: "Senha",
                  suffixIcon: IconButton(
                    icon: Icon(vm.senhaVisivel
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: vm.alternarSenhaVisivel,
                  ),
                ),
                onChanged: (_) => vm.notifyListeners(),
                validator: (_) {
                  if (!vm.senhaValida) {
                    return "A senha não atende os requisitos";
                  }
                  return null;
                },
              ),

              // INDICADORES DE VALIDAÇÃO
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(vm.temMaiuscula ? "✔ Letra maiúscula" : "✖ Letra maiúscula"),
                  Text(vm.temMinuscula ? "✔ Letra minúscula" : "✖ Letra minúscula"),
                  Text(vm.temNumero ? "✔ Número" : "✖ Número"),
                  Text(vm.temEspecial ? "✔ Caractere especial" : "✖ Caractere especial"),
                ],
              ),

              const SizedBox(height: 12),

              // CONFIRMAR SENHA
              TextFormField(
                controller: vm.confirmarSenhaController,
                obscureText: !vm.confirmarSenhaVisivel,
                decoration: InputDecoration(
                  labelText: "Confirmar senha",
                  suffixIcon: IconButton(
                    icon: Icon(vm.confirmarSenhaVisivel
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: vm.alternarConfirmarSenhaVisivel,
                  ),
                ),
                validator: (_) {
                  if (vm.senhaController.text != vm.confirmarSenhaController.text) {
                    return "As senhas não coincidem";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // BOTÃO DE CADASTRO
              ElevatedButton(
                onPressed: vm.formularioValido
                    ? () async {
                        if (formKey.currentState!.validate()) {
                          final sucesso = await vm.cadastrarUsuario();

                          if (sucesso) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Usuário cadastrado!")),
                            );
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Erro ao cadastrar!")),
                            );
                          }
                        }
                      }
                    : null,
                child: vm.carregando
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Cadastrar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
