import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:confeitaria_marketplace/models/confeitaria.dart';
import 'package:confeitaria_marketplace/models/produto.dart';
import 'package:confeitaria_marketplace/main.dart';

class ProdutoFormScreen extends StatefulWidget {
  final Confeitaria confeitaria;
  final Produto? produtoExistente;

  const ProdutoFormScreen({
    Key? key,
    required this.confeitaria,
    this.produtoExistente,
  }) : super(key: key);

  @override
  State<ProdutoFormScreen> createState() => _ProdutoFormScreenState();
}

class _ProdutoFormScreenState extends State<ProdutoFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final descricaoController = TextEditingController();
  final valorController = TextEditingController();
  List<File> imagens = [];

  @override
  void initState() {
    super.initState();
    if (widget.produtoExistente != null) {
      final produto = widget.produtoExistente!;
      nomeController.text = produto.nome;
      descricaoController.text = produto.descricao;
      valorController.text = produto.valor.toString();
      if (produto.imagens.isNotEmpty) {
        try {
          final imagensJson = jsonDecode(produto.imagens) as List<dynamic>;
          imagens = imagensJson.map((e) => File(e)).toList();
        } catch (e) {
          imagens = [];
        }
      }
    }
  }

  Future<void> _selecionarImagens() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();

    if (pickedFiles.isNotEmpty) {
      for (var pickedFile in pickedFiles) {
        final tempDir = await getTemporaryDirectory();
        final fileName = path.basename(pickedFile.path);
        final savedImage = await File(pickedFile.path).copy('${tempDir.path}/$fileName');
        imagens.add(savedImage);
      }
      setState(() {});
    }
  }

  void _salvarProduto() {
    if (_formKey.currentState!.validate()) {
      final imagensPaths = imagens.map((file) => file.path).toList();

      final produto = widget.produtoExistente ??
          Produto(
            nome: '',
            descricao: '',
            valor: 0.0,
            imagens: '[]',
          );

      produto.nome = nomeController.text;
      produto.descricao = descricaoController.text;
      produto.valor = double.tryParse(valorController.text) ?? 0.0;
      produto.imagens = jsonEncode(imagensPaths);
      produto.confeitaria.target = widget.confeitaria;

      objectbox.produtoBox.put(produto);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Produto salvo com sucesso!')),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final titulo = widget.produtoExistente != null ? 'Editar Produto' : 'Novo Produto';

    return Scaffold(
      appBar: AppBar(title: Text(titulo)),
      body: Padding(
        padding: const EdgeInsets.all(16),
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
                controller: descricaoController,
                decoration: InputDecoration(labelText: 'Descrição'),
                maxLines: 3,
              ),
              TextFormField(
                controller: valorController,
                decoration: InputDecoration(labelText: 'Valor (R\$)'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) =>
                    double.tryParse(value ?? '') == null ? 'Valor inválido' : null,
              ),
              SizedBox(height: 20),
              Text('Imagens:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              imagens.isEmpty
                  ? Center(child: Text('Nenhuma imagem selecionada'))
                  : SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: imagens.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Image.file(
                                  imagens[index],
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      imagens.removeAt(index);
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(Icons.close, color: Colors.white, size: 20),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: _selecionarImagens,
                icon: Icon(Icons.add_a_photo),
                label: Text('Selecionar Imagens'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvarProduto,
                child: Text('Salvar Produto'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
