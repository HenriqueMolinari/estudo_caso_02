import 'dart:io';

class ConsoleUtils {
  static void clearScreen() {
    print('\x1B[2J\x1B[0;0H');
  }

  static void showHeader(String title) {
    clearScreen();
    print('═' * 50);
    print('      $title');
    print('═' * 50);
  }

  static void showSuccess(String message) {
    print('✅ $message');
  }

  static void showError(String message) {
    print('❌ $message');
  }

  static void showWarning(String message) {
    print('⚠️  $message');
  }

  static void showInfo(String message) {
    print('ℹ️  $message');
  }

  static String? readString(String prompt, {bool required = true}) {
    stdout.write('$prompt: ');
    final input = stdin.readLineSync()?.trim();
    if (required && (input == null || input.isEmpty)) {
      showError('Este campo é obrigatório');
      return null;
    }
    return input;
  }

  static double? readDouble(String prompt, {bool required = true}) {
    while (true) {
      stdout.write('$prompt: ');
      final input = stdin.readLineSync()?.trim();
      
      if (!required && (input == null || input.isEmpty)) {
        return null;
      }
      
      if (input == null || input.isEmpty) {
        showError('Este campo é obrigatório');
        continue;
      }
      
      try {
        final value = double.parse(input);
        if (value <= 0) {
          showError('O valor deve ser maior que zero');
          continue;
        }
        return value;
      } catch (e) {
        showError('Digite um número válido');
      }
    }
  }

  static int? readInt(String prompt, {bool required = true}) {
    while (true) {
      stdout.write('$prompt: ');
      final input = stdin.readLineSync()?.trim();
      
      if (!required && (input == null || input.isEmpty)) {
        return null;
      }
      
      if (input == null || input.isEmpty) {
        showError('Este campo é obrigatório');
        continue;
      }
      
      try {
        return int.parse(input);
      } catch (e) {
        showError('Digite um número inteiro válido');
      }
    }
  }

  static bool confirm(String message) {
    while (true) {
      stdout.write('$message (s/N): ');
      final input = stdin.readLineSync()?.trim().toLowerCase();
      
      if (input == null || input.isEmpty) {
        return false;
      }
      
      if (input == 's' || input == 'sim') {
        return true;
      } else if (input == 'n' || input == 'nao' || input == 'não') {
        return false;
      } else {
        showError('Digite "s" para sim ou "n" para não');
      }
    }
  }

  static void waitForEnter() {
    print('\nPressione Enter para continuar...');
    stdin.readLineSync();
  }
}