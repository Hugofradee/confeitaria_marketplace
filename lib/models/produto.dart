import 'package:confeitaria_marketplace/models/confeitaria.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Produto {
  int id;
  String nome;
  String descricao;
  double valor;
  String imagens; // armazenar como JSON string


final confeitaria = ToOne<Confeitaria>();

Produto({
  this.id = 0,
  required this.nome,
  required this.descricao,
  required this.valor,
  required this.imagens,
});

}
