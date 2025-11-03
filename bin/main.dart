import 'package:estudocaso2/views/main_view.dart';
import 'package:estudocaso2/database/database_connection.dart';
import 'package:estudocaso2/utils/console_utils.dart';

void main() async {
  ConsoleUtils.showHeader('SISTEMA DE GESTÃO DE FUNCIONÁRIOS - TECHSOLUTIONS');

  // Testar conexão com o banco
  try {
    ConsoleUtils.showInfo('Conectando ao banco de dados...');
    final conexaoOk = await DatabaseConnection.testConnection();
    
    if (!conexaoOk) {
      ConsoleUtils.showError('Não foi possível conectar ao banco de dados!');
      ConsoleUtils.showWarning('Verifique:');
      ConsoleUtils.showWarning('1. Se o MySQL está rodando');
      ConsoleUtils.showWarning('2. As configurações em lib/database/database_config.dart');
      ConsoleUtils.showWarning('3. Se o banco "estudocaso2_db" existe');
      ConsoleUtils.waitForEnter();
      return;
    }
    
    ConsoleUtils.showSuccess('Conexão com o banco de dados estabelecida!');
  } catch (e) {
    ConsoleUtils.showError('Erro ao conectar com o banco: $e');
    ConsoleUtils.waitForEnter();
    return;
  }

  // Executar o menu principal
  await _executarMenuPrincipal();

  // Fechar conexão com o banco
  await DatabaseConnection.close();
  ConsoleUtils.showInfo('Conexão com o banco de dados fechada.');
}

Future<void> _executarMenuPrincipal() async {
  bool executando = true;

  while (executando) {
    try {
      // Chama o menu da MainView
      await MainView.exibirMenuPrincipal();
    } catch (e) {
      ConsoleUtils.showError('Erro inesperado: $e');
      ConsoleUtils.waitForEnter();
    }
  }
}