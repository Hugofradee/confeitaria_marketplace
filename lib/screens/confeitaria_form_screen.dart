import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:confeitaria_marketplace/models/confeitaria.dart';
import 'package:confeitaria_marketplace/main.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class ConfeitariaFormScreen extends StatefulWidget {
  const ConfeitariaFormScreen({super.key});

  @override
  State<ConfeitariaFormScreen> createState() => _ConfeitariaFormScreenState();
}

class _ConfeitariaFormScreenState extends State<ConfeitariaFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final nomeController = TextEditingController();
  final telefoneController = TextEditingController();
  final cepController = TextEditingController();
  final ruaController = TextEditingController();
  final numeroController = TextEditingController();
  final bairroController = TextEditingController();
  final cidadeController = TextEditingController();
  final estadoController = TextEditingController();
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();

  final String googleApiKey = 'AIzaSyDV995FdwdoxaCiayE__Ym3cZePyhWBd6k';

  void _salvarConfeitaria() {
    if (_formKey.currentState!.validate()) {
      final novaConfeitaria = Confeitaria(
        nome: nomeController.text,
        telefone: telefoneController.text,
        cep: cepController.text,
        rua: ruaController.text,
        numero: numeroController.text,
        bairro: bairroController.text,
        cidade: cidadeController.text,
        estado: estadoController.text,
        latitude: double.tryParse(latitudeController.text) ?? 0.0,
        longitude: double.tryParse(longitudeController.text) ?? 0.0,
      );

      objectbox.confeitariaBox.put(novaConfeitaria);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Confeitaria salva com sucesso!')),
      );

      Navigator.pop(context);
    }
  }

  Future<void> _buscarEndereco() async {
    final cep = cepController.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (cep.length != 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Digite um CEP válido com 8 dígitos')),
      );
      return;
    }

    try {
      final response = await http.get(Uri.parse('https://viacep.com.br/ws/$cep/json/'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['erro'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('CEP não encontrado')),
          );
          return;
        }

        setState(() {
          ruaController.text = data['logradouro'] ?? '';
          bairroController.text = data['bairro'] ?? '';
          cidadeController.text = data['localidade'] ?? '';
          estadoController.text = data['uf'] ?? '';
        });

        await _buscarCoordenadas();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao buscar CEP')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: $e')),
      );
    }
  }

  Future<void> _buscarCoordenadas() async {
    final endereco =
        '${ruaController.text}, ${numeroController.text}, ${bairroController.text}, ${cidadeController.text}, ${estadoController.text}';

    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?address=${Uri.encodeComponent(endereco)}&key=$googleApiKey');

    try {
      final response = await http.get(url);
      final data = jsonDecode(response.body);

      if (data['status'] == 'OK') {
        final location = data['results'][0]['geometry']['location'];
        setState(() {
          latitudeController.text = location['lat'].toString();
          longitudeController.text = location['lng'].toString();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Não foi possível obter coordenadas.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao buscar coordenadas: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastrar Confeitaria')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nomeController,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) => value == null || value.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: telefoneController,
                decoration: InputDecoration(labelText: 'Telefone'),
              ),
              TextFormField(
                controller: cepController,
                decoration: InputDecoration(labelText: 'CEP'),
              ),
              SizedBox(height: 8),
              ElevatedButton.icon(
                onPressed: _buscarEndereco,
                icon: Icon(Icons.search),
                label: Text('Buscar CEP'),
              ),
              TextFormField(
                controller: ruaController,
                decoration: InputDecoration(labelText: 'Rua'),
              ),
              TextFormField(
                controller: numeroController,
                decoration: InputDecoration(labelText: 'Número'),
              ),
              TextFormField(
                controller: bairroController,
                decoration: InputDecoration(labelText: 'Bairro'),
              ),
              TextFormField(
                controller: cidadeController,
                decoration: InputDecoration(labelText: 'Cidade'),
              ),
              TextFormField(
                controller: estadoController,
                decoration: InputDecoration(labelText: 'Estado'),
              ),
              TextFormField(
                controller: latitudeController,
                decoration: InputDecoration(labelText: 'Latitude'),
                keyboardType: TextInputType.number,
                readOnly: true,
              ),
              TextFormField(
                controller: longitudeController,
                decoration: InputDecoration(labelText: 'Longitude'),
                keyboardType: TextInputType.number,
                readOnly: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvarConfeitaria,
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
