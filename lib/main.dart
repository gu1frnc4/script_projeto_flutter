import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'viewmodels/cadastro_viewmodel.dart';
import 'viewmodels/login_viewmodel.dart';

import 'views/tela_login.dart';
import 'views/tela_cadastro.dart';
import 'views/tela_principal.dart';
import 'views/tela_resultados.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CadastroViewModel()),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Analisador de Texto",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),

        // Tela inicial do app:
        initialRoute: '/login',

        routes: {
          '/login': (_) => const TelaLogin(),
          '/cadastro': (_) => const TelaCadastro(),

          // Essas precisam de parâmetros, então não se colocam aqui:
          // '/principal'
          // '/resultados'
        },

        // Gerencia telas que recebem argumentos
        onGenerateRoute: (settings) {
          if (settings.name == '/principal') {
            final email = settings.arguments as String;
            return MaterialPageRoute(
              builder: (_) => TelaPrincipal(usuarioEmail: email),
            );
          }

          if (settings.name == '/resultados') {
            final email = settings.arguments as String;
            return MaterialPageRoute(
              builder: (_) => ResultadosView(usuarioEmail: email),
            );
          }

          return null;
        },
      ),
    );
  }
}
