import 'funcionario.dart';

class Gerente extends Funcionario {
  Gerente({
    int? id,
    required String nome,
    required String matricula,
    required double salarioBase,
  }) : super(
          id: id,
          nome: nome,
          matricula: matricula,
          salarioBase: salarioBase,
          tipo: 'Gerente',
        );

  @override
  double calcularBonus() {
    return salarioBase * 0.20;
  }

  factory Gerente.fromMap(Map<String, dynamic> map) {
    return Gerente(
      id: map['id'],
      nome: map['nome'],
      matricula: map['matricula'],
      salarioBase: map['salario_base'].toDouble(),
    );
  }
}