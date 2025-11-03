import 'funcionario.dart';

class Estagiario extends Funcionario {
  Estagiario({
    int? id,
    required String nome,
    required String matricula,
    required double salarioBase,
  }) : super(
          id: id,
          nome: nome,
          matricula: matricula,
          salarioBase: salarioBase,
          tipo: 'Estagiario',
        );

  @override
  double calcularBonus() {
    return salarioBase * 0.05;
  }

  factory Estagiario.fromMap(Map<String, dynamic> map) {
    return Estagiario(
      id: map['id'],
      nome: map['nome'],
      matricula: map['matricula'],
      salarioBase: map['salario_base'].toDouble(),
    );
  }
}