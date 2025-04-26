import 'package:flutter/material.dart';
import 'package:confeitaria_marketplace/models/produto.dart';
import 'package:confeitaria_marketplace/models/confeitaria.dart';
import 'package:confeitaria_marketplace/main.dart';


class ProdutoFormScreen extends StatefulWidget {
  final Confeitaria confeitaria;

  const ProdutoFormScreen({Key? key, required this.confeitaria}) : super(key: key);

  @override
  State<ProdutoFormScreen> createState() => _ProdutoFormScreenState();
}

class _ProdutoFormScreenState extends State<ProdutoFormScreen> {
  final _formKey = GlobalKey<FormState>();

  final nomeController = TextEditingController();
  final descricaoController = TextEditingController();
  final valorController = TextEditingController();
  final imagensController = TextEditingController(); // Simples: insira como string JSON manualmente

  void _salvarProduto() {
  if (_formKey.currentState!.validate()) {
    final produto = Produto(
      nome: nomeController.text,
      descricao: descricaoController.text,
      valor: double.tryParse(valorController.text) ?? 0.0,
      imagens: imagensController.text,
    );

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
    return Scaffold(
      appBar: AppBar(title: Text('Novo Produto')),
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
              ),
              TextFormField(
                controller: valorController,
                decoration: InputDecoration(labelText: 'Valor'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    double.tryParse(value ?? '') == null ? 'Valor inválido' : null,
              ),
              TextFormField(
                controller: imagensController,
                decoration: InputDecoration(labelText: 'Imagens (JSON Ex: ["img1.png"])'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _salvarProduto,
                child: Text('Salvar Produto'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
