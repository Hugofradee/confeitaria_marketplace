import 'dart:convert';
// ignore: unused_import
import 'dart:io';
import 'package:confeitaria_marketplace/screens/produto_form_screen.dart';
import 'package:http/http.dart' as http;
import 'package:confeitaria_marketplace/models/confeitaria.dart';
import 'package:confeitaria_marketplace/main.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:path/path.dart' as path;
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';


class ConfeitariaFormScreen extends StatefulWidget {
  final Confeitaria? confeitariaExistente;

  const ConfeitariaFormScreen({Key? key, this.confeitariaExistente}) : super(key: key);

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

  @override
  void initState() {
    super.initState();
    if (widget.confeitariaExistente != null) {
      final confeitaria = widget.confeitariaExistente!;
      nomeController.text = confeitaria.nome;
      telefoneController.text = confeitaria.telefone;
      cepController.text = confeitaria.cep;
      ruaController.text = confeitaria.rua;
      numeroController.text = confeitaria.numero;
      bairroController.text = confeitaria.bairro;
      cidadeController.text = confeitaria.cidade;
      estadoController.text = confeitaria.estado;
      latitudeController.text = confeitaria.latitude.toString();
      longitudeController.text = confeitaria.longitude.toString();
    }
  }

  void _salvarConfeitaria() {
    if (_formKey.currentState!.validate()) {
      final confeitaria = widget.confeitariaExistente ?? Confeitaria(
        nome: '',
        telefone: '',
        cep: '',
        rua: '',
        numero: '', // <-- Agora adicionamos o numero aqui
        bairro: '',
        cidade: '',
        estado: '',
        latitude: 0.0,
        longitude: 0.0,
      );
      confeitaria.nome = nomeController.text;
      confeitaria.telefone = telefoneController.text;
      confeitaria.cep = cepController.text;
      confeitaria.rua = ruaController.text;
      confeitaria.numero = numeroController.text;
      confeitaria.bairro = bairroController.text;
      confeitaria.cidade = cidadeController.text;
      confeitaria.estado = estadoController.text;
      confeitaria.latitude = double.tryParse(latitudeController.text) ?? 0.0;
      confeitaria.longitude = double.tryParse(longitudeController.text) ?? 0.0;

      objectbox.confeitariaBox.put(confeitaria);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Confeitaria salva com sucesso!')),
      );

      if (widget.confeitariaExistente == null) {
        // Se for edição, redireciona para criar Produto
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ProdutoFormScreen(confeitaria: confeitaria),
          ),
        );
      } else {
        // Se for cadastro novo, apenas fecha
        Navigator.pop(context);
      }
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
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  MaskedInputFormatter('(##) #####-####'),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Campo obrigatório';
                  if (value.length < 14) return 'Telefone inválido';
                  return null;
                },
              ),
              TextFormField(
                controller: cepController,
                decoration: InputDecoration(labelText: 'CEP'),
                keyboardType: TextInputType.number,
                inputFormatters: [MaskedInputFormatter('#####-###')],
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Campo obrigatório';
                  if (value.length < 9) return 'CEP inválido';
                  return null;
                },
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
