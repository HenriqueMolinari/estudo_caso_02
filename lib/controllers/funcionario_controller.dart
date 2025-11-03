import '../models/funcionario.dart';
import '../models/gerente.dart';
import '../models/desenvolvedor.dart';
import '../models/estagiario.dart';
import '../database/funcionario_repository.dart';

class FuncionarioController {
  static Future<Funcionario> criarFuncionario({
    required String nome,
    required String matricula,
    required double salarioBase,
    required String tipo,
  }) async {
    final existente = await FuncionarioRepository.findByMatricula(matricula);
    if (existente != null) {
      throw Exception('Matrícula $matricula já está em uso');
    }

    Funcionario funcionario;
    
    switch (tipo) {
      case 'Gerente':
        funcionario = Gerente(
          nome: nome,
          matricula: matricula,
          salarioBase: salarioBase,
        );
        break;
      case 'Desenvolvedor':
        funcionario = Desenvolvedor(
          nome: nome,
          matricula: matricula,
          salarioBase: salarioBase,
        );
        break;
      case 'Estagiario':
        funcionario = Estagiario(
          nome: nome,
          matricula: matricula,
          salarioBase: salarioBase,
        );
        break;
      default:
        throw ArgumentError('Tipo de funcionário inválido: $tipo');
    }
    
    final id = await FuncionarioRepository.create(funcionario);
    
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

  static Future<List<Funcionario>> listarFuncionarios() async {
    return await FuncionarioRepository.findAll();
  }

  static Future<Funcionario?> buscarFuncionario(int id) async {
    return await FuncionarioRepository.findById(id);
  }

  static Future<Funcionario?> buscarPorMatricula(String matricula) async {
    return await FuncionarioRepository.findByMatricula(matricula);
  }

  static Future<void> atualizarFuncionario(Funcionario funcionario) async {
    await FuncionarioRepository.update(funcionario);
  }

  static Future<void> deletarFuncionario(int id) async {
    await FuncionarioRepository.delete(id);
  }

  static Future<double> calcularTotalBonus() async {
    final funcionarios = await listarFuncionarios();
    return funcionarios.fold<double>(0.0, (total, func) => total + func.calcularBonus());
  }

  static Future<double> calcularFolhaSalarial() async {
    final funcionarios = await listarFuncionarios();
    return funcionarios.fold<double>(0.0, (total, func) => total + func.salarioBase);
  }

  static Future<int> contarFuncionarios() async {
    return await FuncionarioRepository.count();
  }
}