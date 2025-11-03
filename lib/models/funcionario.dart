// Adicionar os imports no início do arquivo
import 'gerente.dart';
import 'desenvolvedor.dart';
import 'estagiario.dart';

abstract class Funcionario {
  int? _id;
  String _nome;
  String _matricula;
  double _salarioBase;
  String _tipo;

  Funcionario({
    int? id,
    required String nome,
    required String matricula,
    required double salarioBase,
    required String tipo,
  })  : _id = id,
        _nome = nome,
        _matricula = matricula,
        _salarioBase = salarioBase,
        _tipo = tipo;

  // Getters
  int? get id => _id;
  String get nome => _nome;
  String get matricula => _matricula;
  double get salarioBase => _salarioBase;
  String get tipo => _tipo;

  // Setters com validação
  set nome(String nome) {
    if (nome.isEmpty) {
      throw ArgumentError('Nome não pode ser vazio');
    }
    _nome = nome;
  }

  set matricula(String matricula) {
    if (matricula.isEmpty) {
      throw ArgumentError('Matrícula não pode ser vazia');
    }
    _matricula = matricula;
  }

  set salarioBase(double salarioBase) {
    if (salarioBase <= 0) {
      throw ArgumentError('Salário base deve ser maior que zero');
    }
    _salarioBase = salarioBase;
  }

  // Método abstrato para cálculo de bônus
  double calcularBonus();

  // Método para converter para Map (útil para o banco)
  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'nome': _nome,
      'matricula': _matricula,
      'salario_base': _salarioBase,
      'tipo': _tipo,
    };
  }

  // Método para criar a partir de Map - CORRIGIDO
  factory Funcionario.fromMap(Map<String, dynamic> map) {
    final tipo = map['tipo'];
    final id = map['id'];
    final nome = map['nome'];
    final matricula = map['matricula'];
    
    // Converter salario_base para double de forma segura
    double salarioBase;
    if (map['salario_base'] is double) {
      salarioBase = map['salario_base'];
    } else if (map['salario_base'] is int) {
      salarioBase = (map['salario_base'] as int).toDouble();
    } else {
      salarioBase = double.parse(map['salario_base'].toString());
    }

    switch (tipo) {
      case 'Gerente':
        return Gerente(
          id: id,
          nome: nome,
          matricula: matricula,
          salarioBase: salarioBase,
        );
      case 'Desenvolvedor':
        return Desenvolvedor(
          id: id,
          nome: nome,
          matricula: matricula,
          salarioBase: salarioBase,
        );
      case 'Estagiario':
        return Estagiario(
          id: id,
          nome: nome,
          matricula: matricula,
          salarioBase: salarioBase,
        );
      default:
        throw ArgumentError('Tipo de funcionário inválido: $tipo');
    }
  }

  @override
  String toString() {
    return '''
Funcionário: $nome
Cargo: $tipo
Matrícula: $matricula
Salário: R\$ ${salarioBase.toStringAsFixed(2)}
Bônus: R\$ ${calcularBonus().toStringAsFixed(2)}
''';
  }
}