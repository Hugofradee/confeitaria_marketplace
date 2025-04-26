import 'package:path_provider/path_provider.dart';
import 'package:confeitaria_marketplace/models/confeitaria.dart';
import 'package:confeitaria_marketplace/models/produto.dart';
import 'package:confeitaria_marketplace/objectbox.g.dart';

class ObjectBoxStore {
  late final Store store;
  late final Box<Confeitaria> confeitariaBox;
  late final Box<Produto> produtoBox;

  ObjectBoxStore._create(this.store) {
    confeitariaBox = Box<Confeitaria>(store);
    produtoBox = Box<Produto>(store);
  }

  static Future<ObjectBoxStore> create() async {
    final dir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: '${dir.path}/objectbox');
    return ObjectBoxStore._create(store);
  }

    void excluirConfeitariaComProdutos(Confeitaria confeitaria) {
      store.runInTransaction(TxMode.write, () {
        final confeitariaAtualizada = confeitariaBox.get(confeitaria.id);

        if (confeitariaAtualizada != null) {
           // Exclui os produtos
           for (final produto in confeitariaAtualizada.produtos) {
              produtoBox.remove(produto.id);
      }

      // Limpa a lista de produtos
        confeitariaAtualizada.produtos.clear();
        confeitariaBox.put(confeitariaAtualizada);

      // Exclui a confeitaria
        final sucesso = confeitariaBox.remove(confeitariaAtualizada.id);
        print('Confeitaria excluída? $sucesso');
        } else {
        print('Confeitaria não encontrada para exclusão.');
      }
    });
  }
}