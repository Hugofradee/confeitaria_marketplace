import 'package:objectbox/objectbox.dart';
import 'package:confeitaria_marketplace/models/produto.dart';

@Entity()
class Confeitaria {
  int id;
  String nome;
  String telefone;
  String cep;
  String rua;
  String numero;
  String bairro;
  String cidade;
  String estado;
  double latitude;
  double longitude;

  @Backlink('confeitaria')
  final ToMany<Produto> produtos = ToMany<Produto>();

  Confeitaria({
    this.id = 0,
    required this.nome,
    required this.telefone,
    required this.cep,
    required this.rua,
    required this.numero,
    required this.bairro,
    required this.cidade,
    required this.estado,
    required this.latitude,
    required this.longitude,
  });
}
