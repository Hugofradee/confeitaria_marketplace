import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:confeitaria_marketplace/models/confeitaria.dart';
import 'package:confeitaria_marketplace/models/produto.dart';
import 'package:confeitaria_marketplace/objectbox.g.dart';
import 'package:confeitaria_marketplace/objectbox_store.dart';
import 'package:confeitaria_marketplace/screens/home_screen.dart';
import 'package:confeitaria_marketplace/screens/confeitaria_form_screen.dart';
import 'package:confeitaria_marketplace/screens/confeitaria_detail_screen.dart';
import 'package:confeitaria_marketplace/screens/produto_form_screen.dart';


late final ObjectBoxStore objectbox;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  objectbox = await ObjectBoxStore.create();

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Confeitaria Marketplace',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      initialRoute: '/',
      routes: {
       '/': (context) => HomeScreen(),                      // Tela inicial com mapa + lista
        '/confeitaria-form': (context) => ConfeitariaFormScreen(), // Cadastro/edição
      },
    );
  }
}