import 'funcionario.dart';

class Desenvolvedor extends Funcionario {
  Desenvolvedor({
    int? id,
    required String nome,
    required String matricula,
    required double salarioBase,
  }) : super(
          id: id,
          nome: nome,
          matricula: matricula,
          salarioBase: salarioBase,
          tipo: 'Desenvolvedor',
        );

  @override
  double calcularBonus() {
    return salarioBase * 0.10;
  }

  factory Desenvolvedor.fromMap(Map<String, dynamic> map) {
    return Desenvolvedor(
      id: map['id'],
      nome: map['nome'],
      matricula: map['matricula'],
      salarioBase: map['salario_base'].toDouble(),
    );
  }
}