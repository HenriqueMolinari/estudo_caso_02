import '../services/funcionario_service.dart';
import '../utils/console_utils.dart';

class RelatorioView {
  static Future<void> exibirRelatorioCompleto() async {
    ConsoleUtils.showHeader('RELATÓRIO COMPLETO');

    try {
      final estatisticas = await FuncionarioService.calcularEstatisticas();
      final custosPorCargo = await FuncionarioService.calcularCustoPorCargo();

      print('📊 ESTATÍSTICAS GERAIS');
      print('─' * 40);
      print('• Total de Funcionários: ${estatisticas['totalFuncionarios']}');
      print('• Folha Salarial Mensal: R\$ ${estatisticas['folhaSalarial']!.toStringAsFixed(2)}');
      print('• Total de Bônus Anual: R\$ ${estatisticas['totalBonus']!.toStringAsFixed(2)}');
      print('• Custo Total Anual: R\$ ${(estatisticas['folhaSalarial']! * 12 + estatisticas['totalBonus']!).toStringAsFixed(2)}');
      print('• Maior Salário: R\$ ${estatisticas['maiorSalario']!.toStringAsFixed(2)}');
      print('• Menor Salário: R\$ ${estatisticas['menorSalario']!.toStringAsFixed(2)}');
      print('• Média Salarial: R\$ ${estatisticas['mediaSalarial']!.toStringAsFixed(2)}');

      final distribuicao = estatisticas['distribuicaoCargos'] as Map<String, int>;
      if (distribuicao.isNotEmpty) {
        print('\n👥 DISTRIBUIÇÃO POR CARGO');
        print('─' * 40);
        distribuicao.forEach((cargo, quantidade) {
          final percentual = (quantidade / estatisticas['totalFuncionarios']! * 100).toStringAsFixed(1);
          print('• $cargo: $quantidade funcionário(s) ($percentual%)');
        });
      }

      if (custosPorCargo.isNotEmpty) {
        print('\n💰 CUSTO MENSAL POR CARGO');
        print('─' * 40);
        custosPorCargo.forEach((cargo, custo) {
          print('• $cargo: R\$ ${custo.toStringAsFixed(2)}');
        });
      }

      print('\n🎯 PROJEÇÕES ANUAIS');
      print('─' * 40);
      print('• Folha Salarial Anual: R\$ ${(estatisticas['folhaSalarial']! * 12).toStringAsFixed(2)}');
      print('• Custo Total com Bônus: R\$ ${(estatisticas['folhaSalarial']! * 12 + estatisticas['totalBonus']!).toStringAsFixed(2)}');

    } catch (e) {
      ConsoleUtils.showError('Erro ao gerar relatório: $e');
    }
  }

  static Future<void> exibirRelatorioPorCargo() async {
    ConsoleUtils.showHeader('RELATÓRIO POR CARGO');

    print('Selecione o cargo:');
    print('1. Gerente');
    print('2. Desenvolvedor');
    print('3. Estagiário');

    final opcao = ConsoleUtils.readString('Opção');
    if (opcao == null) return;

    String cargo;
    switch (opcao) {
      case '1':
        cargo = 'Gerente';
        break;
      case '2':
        cargo = 'Desenvolvedor';
        break;
      case '3':
        cargo = 'Estagiario';
        break;
      default:
        ConsoleUtils.showError('Opção inválida!');
        return;
    }

    try {
      final funcionarios = await FuncionarioService.buscarPorCargo(cargo);
      
      if (funcionarios.isEmpty) {
        ConsoleUtils.showInfo('Nenhum funcionário encontrado para o cargo $cargo.');
        return;
      }

      print('\n👥 FUNCIONÁRIOS - $cargo');
      print('─' * 40);

      double totalSalarios = 0;
      double totalBonus = 0;

      for (var funcionario in funcionarios) {
        print(funcionario);
        totalSalarios += funcionario.salarioBase;
        totalBonus += funcionario.calcularBonus();
        print('─' * 30);
      }

      print('\n📊 RESUMO DO CARGO: $cargo');
      print('• Total de Funcionários: ${funcionarios.length}');
      print('• Total de Salários: R\$ ${totalSalarios.toStringAsFixed(2)}');
      print('• Total de Bônus: R\$ ${totalBonus.toStringAsFixed(2)}');
      print('• Custo Total Mensal: R\$ ${(totalSalarios + totalBonus).toStringAsFixed(2)}');

    } catch (e) {
      ConsoleUtils.showError('Erro ao gerar relatório: $e');
    }
  }

  static Future<void> exibirRelatorioFaixaSalarial() async {
    ConsoleUtils.showHeader('RELATÓRIO POR FAIXA SALARIAL');

    final min = ConsoleUtils.readDouble('Salário mínimo') ?? 0;
    final max = ConsoleUtils.readDouble('Salário máximo') ?? double.maxFinite;

    if (min > max) {
      ConsoleUtils.showError('Salário mínimo não pode ser maior que o máximo!');
      return;
    }

    try {
      final funcionarios = await FuncionarioService.buscarPorFaixaSalarial(min, max);
      
      if (funcionarios.isEmpty) {
        ConsoleUtils.showInfo('Nenhum funcionário encontrado na faixa salarial de R\$ ${min.toStringAsFixed(2)} a R\$ ${max.toStringAsFixed(2)}.');
        return;
      }

      print('\n👥 FUNCIONÁRIOS NA FAIXA SALARIAL');
      print('Faixa: R\$ ${min.toStringAsFixed(2)} - R\$ ${max.toStringAsFixed(2)}');
      print('─' * 50);

      for (var funcionario in funcionarios) {
        print(funcionario);
        print('─' * 30);
      }

      print('\n📊 RESUMO DA FAIXA SALARIAL');
      print('• Total de Funcionários: ${funcionarios.length}');
      print('• Faixa: R\$ ${min.toStringAsFixed(2)} - R\$ ${max.toStringAsFixed(2)}');

    } catch (e) {
      ConsoleUtils.showError('Erro ao gerar relatório: $e');
    }
  }
}