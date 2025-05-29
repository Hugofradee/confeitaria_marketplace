import 'dart:convert';
import 'dart:io';
import 'package:confeitaria_marketplace/features/confeitaria/view/confeitaria_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:confeitaria_marketplace/models/confeitaria.dart';
import 'package:confeitaria_marketplace/models/produto.dart';
import 'package:confeitaria_marketplace/screens/produto_form_screen.dart';
import 'package:confeitaria_marketplace/main.dart';

class ConfeitariaDetailScreen extends StatefulWidget {
  final Confeitaria confeitaria;

  const ConfeitariaDetailScreen({super.key, required this.confeitaria});

  @override
  State<ConfeitariaDetailScreen> createState() =>
      _ConfeitariaDetailScreenState();
}

class _ConfeitariaDetailScreenState extends State<ConfeitariaDetailScreen> {
  List<Produto> produtos = [];

  @override
  void initState() {
    super.initState();
    _carregarProdutos();
  }

  void _carregarProdutos() {
    final confeitariaAtualizada = objectbox.confeitariaBox.get(
      widget.confeitaria.id,
    );

    if (confeitariaAtualizada != null) {
      setState(() {
        produtos = confeitariaAtualizada.produtos.toList();
      });
    }
  }

  void _irParaCadastroDeProduto() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => ProdutoFormScreen(confeitaria: widget.confeitaria),
      ),
    ).then((_) => _carregarProdutos());
  }

  void _confirmarExclusao() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Excluir Confeitaria'),
            content: Text(
              'Deseja realmente excluir esta confeitaria e seus produtos?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  objectbox.excluirConfeitariaComProdutos(widget.confeitaria);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text('Excluir', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
    );
  }

  void _editarConfeitaria() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) =>
                ConfeitariaFormScreen(confeitariaExistente: widget.confeitaria),
      ),
    ).then((_) {
      setState(() {
        _carregarProdutos(); // Atualiza a tela depois de editar
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final confeitaria = widget.confeitaria;

    return Scaffold(
      appBar: AppBar(
        title: Text(confeitaria.nome),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
        backgroundColor: const Color.fromARGB(255, 95, 84, 113),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.edit), // Ícone de edição
            tooltip: 'Editar Confeitaria',
            onPressed: _editarConfeitaria, // Função de editar
          ),
          IconButton(icon: Icon(Icons.delete), onPressed: _confirmarExclusao),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Endereço: ${confeitaria.rua}, ${confeitaria.numero}, ${confeitaria.bairro}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Cidade: ${confeitaria.cidade} - ${confeitaria.estado} - ${confeitaria.cep}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Telefone: ${confeitaria.telefone}',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Localização: ${confeitaria.latitude}, ${confeitaria.longitude}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Produtos:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child:
                  produtos.isEmpty
                      ? Center(child: Text('Nenhum produto cadastrado.'))
                      : ListView.builder(
                        itemCount: produtos.length,
                        itemBuilder: (context, index) {
                          final produto = produtos[index];
                          List<dynamic> imagens = [];
                          if (produto.imagens.trim().isNotEmpty) {
                            try {
                              imagens =
                                  jsonDecode(produto.imagens) as List<dynamic>;
                            } catch (e) {
                              imagens = [];
                            }
                          }
                          final primeiraImagem =
                              imagens.isNotEmpty ? imagens[0] : null;

                          return Card(
                            elevation: 2,
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              leading:
                                  (primeiraImagem != null &&
                                          File(primeiraImagem).existsSync())
                                      ? Image.file(
                                        File(primeiraImagem),
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      )
                                      : Icon(
                                        Icons.image_not_supported,
                                        size: 40,
                                      ),
                              title: Text(produto.nome),
                              subtitle: Text(produto.descricao),
                              trailing: Text(
                                'R\$ ${produto.valor.toStringAsFixed(2)}',
                              ),
                              onTap: () {},
                            ),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _irParaCadastroDeProduto,
        tooltip: 'Adicionar Produto',
        child: Icon(Icons.add),
      ),
    );
  }
}
