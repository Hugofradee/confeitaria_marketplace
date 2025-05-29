import 'package:confeitaria_marketplace/objectbox_store.dart';
import 'package:confeitaria_marketplace/screens/confeitaria_form_screen.dart';
import 'package:flutter/material.dart';

import 'features/map/view/map_page.dart';

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
      theme: ThemeData(primarySwatch: Colors.pink),
      initialRoute: '/',
      routes: {
        '/': (context) => MapPage(), // Tela inicial com mapa + lista
        '/confeitaria-form':
            (context) => ConfeitariaFormScreen(), // Cadastro/edição
      },
    );
  }
}
