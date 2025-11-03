import 'dart:io';
import '../controllers/funcionario_controller.dart';
import '../utils/console_utils.dart';
import 'relatorio_view.dart';
import '../services/funcionario_service.dart';

class MainView {
  static Future<void> exibirMenuPrincipal() async {
    ConsoleUtils.showHeader('MENU PRINCIPAL');
    print('1. 📝 Cadastrar Funcionário');
    print('2. 📋 Listar Todos os Funcionários');
    print('3. 🔍 Buscar Funcionário por ID');
    print('4. 🔎 Buscar Funcionário por Matrícula');
    print('5. ✏️  Atualizar Funcionário');
    print('6. 🗑️  Deletar Funcionário');
    print('7. 📊 Relatórios e Estatísticas');
    print('8. ℹ️  Sobre o Sistema');
    print('9. 🚪 Sair');
    print('─' * 50);
    stdout.write('Escolha uma opção: ');

    final opcao = stdin.readLineSync()?.trim() ?? '';

    switch (opcao) {
      case '1':
        await cadastrarFuncionario();
        break;
      case '2':
        await listarFuncionarios();
        break;
      case '3':
        await buscarPorId();
        break;
      case '4':
        await buscarPorMatricula();
        break;
      case '5':
        await atualizarFuncionario();
        break;
      case '6':
        await deletarFuncionario();
        break;
      case '7':
        await _exibirMenuRelatorios();
        break;
      case '8':
        await _exibirSobre();
        break;
      case '9':
        ConsoleUtils.showSuccess('Obrigado por usar o Sistema de Gestão de Funcionários!');
        exit(0);
      default:
        ConsoleUtils.showError('Opção inválida! Escolha uma opção de 1 a 9.');
    }

    ConsoleUtils.waitForEnter();
  }

  static Future<void> _exibirMenuRelatorios() async {
    bool voltar = false;

    while (!voltar) {
      ConsoleUtils.showHeader('RELATÓRIOS E ESTATÍSTICAS');
      print('1. 📈 Relatório Completo');
      print('2. 👥 Relatório por Cargo');
      print('3. 💰 Relatório por Faixa Salarial');
      print('4. 📋 Estatísticas Gerais');
      print('5. 🔙 Voltar ao Menu Principal');
      print('─' * 50);
      stdout.write('Escolha uma opção: ');

      final opcao = stdin.readLineSync()?.trim() ?? '';

      switch (opcao) {
        case '1':
          await RelatorioView.exibirRelatorioCompleto();
          break;
        case '2':
          await RelatorioView.exibirRelatorioPorCargo();
          break;
        case '3':
          await RelatorioView.exibirRelatorioFaixaSalarial();
          break;
        case '4':
          await exibirRelatorios();
          break;
        case '5':
          voltar = true;
          break;
        default:
          ConsoleUtils.showError('Opção inválida!');
      }

      if (!voltar) {
        ConsoleUtils.waitForEnter();
      }
    }
  }

  static Future<void> _exibirSobre() async {
    ConsoleUtils.showHeader('SOBRE O SISTEMA');
    
    print('Sistema de Gestão de Funcionários - TechSolutions');
    print('Versão: 1.0.0');
    print('Desenvolvido em Dart com MySQL');
    print('\n🎯 CARACTERÍSTICAS:');
    print('• Arquitetura MVC (Model-View-Controller)');
    print('• Princípios de POO (Programação Orientada a Objetos)');
    print('• Operações CRUD completas');
    print('• Cálculo automático de bônus');
    print('• Relatórios e estatísticas detalhadas');
    print('• Validação de dados robusta');
    print('• Interface de console amigável');
    
    try {
      final totalFunc = await FuncionarioController.contarFuncionarios();
      print('\n📊 ESTATÍSTICAS ATUAIS:');
      print('• Funcionários cadastrados: $totalFunc');
      
      if (totalFunc > 0) {
        final estatisticas = await FuncionarioService.calcularEstatisticas();
        print('• Folha salarial mensal: R\$ ${estatisticas['folhaSalarial']!.toStringAsFixed(2)}');
        print('• Custo anual projetado: R\$ ${(estatisticas['folhaSalarial']! * 12 + estatisticas['totalBonus']!).toStringAsFixed(2)}');
      }
    } catch (e) {
      // Ignora erros nas estatísticas
    }
    
    print('\n💡 DICAS:');
    print('• Configure o banco em lib/database/database_config.dart');
    print('• Execute o script SQL fornecido para criar o banco');
    print('• Use as opções de relatório para análises detalhadas');
  }

  // Os métodos restantes permanecem iguais...
  static Future<void> cadastrarFuncionario() async {
    ConsoleUtils.showHeader('CADASTRO DE FUNCIONÁRIO');

    final nome = ConsoleUtils.readString('Nome');
    if (nome == null) return;

    final matricula = ConsoleUtils.readString('Matrícula');
    if (matricula == null) return;

    final salarioBase = ConsoleUtils.readDouble('Salário Base');
    if (salarioBase == null) return;

    print('\nTipos de Funcionário:');
    print('1. Gerente (20% de bônus)');
    print('2. Desenvolvedor (10% de bônus)');
    print('3. Estagiário (5% de bônus)');

    String tipo;
    while (true) {
      final opcaoTipo = ConsoleUtils.readString('Escolha o tipo (1-3)');
      if (opcaoTipo == null) return;
      
      switch (opcaoTipo) {
        case '1':
          tipo = 'Gerente';
          break;
        case '2':
          tipo = 'Desenvolvedor';
          break;
        case '3':
          tipo = 'Estagiario';
          break;
        default:
          ConsoleUtils.showError('Opção inválida! Escolha 1, 2 ou 3.');
          continue;
      }
      break;
    }

    try {
      final funcionario = await FuncionarioController.criarFuncionario(
        nome: nome,
        matricula: matricula,
        salarioBase: salarioBase,
        tipo: tipo,
      );
      
      ConsoleUtils.showSuccess('Funcionário cadastrado com sucesso!');
      print(funcionario);
    } catch (e) {
      ConsoleUtils.showError('Erro ao cadastrar funcionário: $e');
    }
  }

  static Future<void> listarFuncionarios() async {
    ConsoleUtils.showHeader('LISTA DE FUNCIONÁRIOS');

    try {
      final funcionarios = await FuncionarioController.listarFuncionarios();
      
      if (funcionarios.isEmpty) {
        ConsoleUtils.showInfo('Nenhum funcionário cadastrado.');
        return;
      }

      for (var funcionario in funcionarios) {
        print(funcionario);
        print('─' * 30);
      }

      ConsoleUtils.showInfo('Total de funcionários: ${funcionarios.length}');
    } catch (e) {
      ConsoleUtils.showError('Erro ao listar funcionários: $e');
    }
  }

  static Future<void> buscarPorId() async {
    ConsoleUtils.showHeader('BUSCAR FUNCIONÁRIO POR ID');

    final id = ConsoleUtils.readInt('Digite o ID');
    if (id == null) return;

    try {
      final funcionario = await FuncionarioController.buscarFuncionario(id);
      
      if (funcionario == null) {
        ConsoleUtils.showError('Funcionário com ID $id não encontrado.');
      } else {
        ConsoleUtils.showSuccess('Funcionário encontrado:');
        print(funcionario);
      }
    } catch (e) {
      ConsoleUtils.showError('Erro ao buscar funcionário: $e');
    }
  }

  static Future<void> buscarPorMatricula() async {
    ConsoleUtils.showHeader('BUSCAR FUNCIONÁRIO POR MATRÍCULA');

    final matricula = ConsoleUtils.readString('Digite a matrícula');
    if (matricula == null) return;

    try {
      final funcionario = await FuncionarioController.buscarPorMatricula(matricula);
      
      if (funcionario == null) {
        ConsoleUtils.showError('Funcionário com matrícula $matricula não encontrado.');
      } else {
        ConsoleUtils.showSuccess('Funcionário encontrado:');
        print(funcionario);
      }
    } catch (e) {
      ConsoleUtils.showError('Erro ao buscar funcionário: $e');
    }
  }

  static Future<void> atualizarFuncionario() async {
    ConsoleUtils.showHeader('ATUALIZAR FUNCIONÁRIO');

    final id = ConsoleUtils.readInt('Digite o ID do funcionário a ser atualizado');
    if (id == null) return;

    try {
      final funcionario = await FuncionarioController.buscarFuncionario(id);
      
      if (funcionario == null) {
        ConsoleUtils.showError('Funcionário com ID $id não encontrado.');
        return;
      }

      print('\nFuncionário atual:');
      print(funcionario);

      print('\nDeixe em branco para manter o valor atual.');

      final novoNome = ConsoleUtils.readString('Novo nome', required: false);
      if (novoNome != null && novoNome.isNotEmpty) {
        funcionario.nome = novoNome;
      }

      final novaMatricula = ConsoleUtils.readString('Nova matrícula', required: false);
      if (novaMatricula != null && novaMatricula.isNotEmpty) {
        funcionario.matricula = novaMatricula;
      }

      final novoSalario = ConsoleUtils.readDouble('Novo salário', required: false);
      if (novoSalario != null) {
        funcionario.salarioBase = novoSalario;
      }

      await FuncionarioController.atualizarFuncionario(funcionario);
      ConsoleUtils.showSuccess('Funcionário atualizado com sucesso!');
      print(funcionario);
    } catch (e) {
      ConsoleUtils.showError('Erro ao atualizar funcionário: $e');
    }
  }

  static Future<void> deletarFuncionario() async {
    ConsoleUtils.showHeader('DELETAR FUNCIONÁRIO');

    final id = ConsoleUtils.readInt('Digite o ID do funcionário a ser deletado');
    if (id == null) return;

    try {
      final funcionario = await FuncionarioController.buscarFuncionario(id);
      
      if (funcionario == null) {
        ConsoleUtils.showError('Funcionário com ID $id não encontrado.');
        return;
      }

      print('\nFuncionário a ser deletado:');
      print(funcionario);

      final confirmacao = ConsoleUtils.confirm('Tem certeza que deseja deletar este funcionário?');
      if (confirmacao) {
        await FuncionarioController.deletarFuncionario(id);
        ConsoleUtils.showSuccess('Funcionário deletado com sucesso!');
      } else {
        ConsoleUtils.showInfo('Operação cancelada.');
      }
    } catch (e) {
      ConsoleUtils.showError('Erro ao deletar funcionário: $e');
    }
  }

  static Future<void> exibirRelatorios() async {
    ConsoleUtils.showHeader('RELATÓRIOS E ESTATÍSTICAS');

    try {
      final totalFuncionarios = await FuncionarioController.contarFuncionarios();
      final folhaSalarial = await FuncionarioController.calcularFolhaSalarial();
      final totalBonus = await FuncionarioController.calcularTotalBonus();
      final funcionarios = await FuncionarioController.listarFuncionarios();

      print('📊 Estatísticas Gerais:');
      print('─' * 40);
      print('• Total de Funcionários: $totalFuncionarios');
      print('• Folha Salarial Mensal: R\$ ${folhaSalarial.toStringAsFixed(2)}');
      print('• Total de Bônus Anual: R\$ ${totalBonus.toStringAsFixed(2)}');
      print('• Custo Total Anual: R\$ ${(folhaSalarial * 12 + totalBonus).toStringAsFixed(2)}');

      if (funcionarios.isNotEmpty) {
        print('\n👥 Distribuição por Cargo:');
        print('─' * 40);
        final distribuicao = <String, int>{};
        for (var func in funcionarios) {
          distribuicao[func.tipo] = (distribuicao[func.tipo] ?? 0) + 1;
        }
        
        distribuicao.forEach((cargo, quantidade) {
          final percentual = (quantidade / totalFuncionarios * 100).toStringAsFixed(1);
          print('• $cargo: $quantidade ($percentual%)');
        });
      }
    } catch (e) {
      ConsoleUtils.showError('Erro ao gerar relatórios: $e');
    }
  }
}