import '../models/funcionario.dart';
import '../controllers/funcionario_controller.dart';

class FuncionarioService {
  static Future<Map<String, dynamic>> calcularEstatisticas() async {
    final funcionarios = await FuncionarioController.listarFuncionarios();
    
    if (funcionarios.isEmpty) {
      return {
        'totalFuncionarios': 0,
        'folhaSalarial': 0.0,
        'totalBonus': 0.0,
        'distribuicaoCargos': {},
        'maiorSalario': null,
        'menorSalario': null,
        'mediaSalarial': 0.0,
      };
    }

    final distribuicao = <String, int>{};
    double maiorSalario = 0;
    double menorSalario = double.maxFinite;
    double somaSalarios = 0;

    for (var funcionario in funcionarios) {
      distribuicao[funcionario.tipo] = (distribuicao[funcionario.tipo] ?? 0) + 1;
      
      if (funcionario.salarioBase > maiorSalario) {
        maiorSalario = funcionario.salarioBase;
      }
      if (funcionario.salarioBase < menorSalario) {
        menorSalario = funcionario.salarioBase;
      }
      
      somaSalarios += funcionario.salarioBase;
    }

    final folhaSalarial = somaSalarios;
    final totalBonus = await FuncionarioController.calcularTotalBonus();
    final mediaSalarial = somaSalarios / funcionarios.length;

    return {
      'totalFuncionarios': funcionarios.length,
      'folhaSalarial': folhaSalarial,
      'totalBonus': totalBonus,
      'distribuicaoCargos': distribuicao,
      'maiorSalario': maiorSalario,
      'menorSalario': menorSalario == double.maxFinite ? 0 : menorSalario,
      'mediaSalarial': mediaSalarial,
    };
  }

  static Future<List<Funcionario>> buscarPorCargo(String cargo) async {
    final funcionarios = await FuncionarioController.listarFuncionarios();
    return funcionarios.where((f) => f.tipo == cargo).toList();
  }

  static Future<List<Funcionario>> buscarPorFaixaSalarial(double min, double max) async {
    final funcionarios = await FuncionarioController.listarFuncionarios();
    return funcionarios
        .where((f) => f.salarioBase >= min && f.salarioBase <= max)
        .toList();
  }

  static Future<Map<String, double>> calcularCustoPorCargo() async {
    final funcionarios = await FuncionarioController.listarFuncionarios();
    final custos = <String, double>{};

    for (var funcionario in funcionarios) {
      final custoTotal = funcionario.salarioBase + funcionario.calcularBonus();
      custos[funcionario.tipo] = (custos[funcionario.tipo] ?? 0) + custoTotal;
    }

    return custos;
  }
}