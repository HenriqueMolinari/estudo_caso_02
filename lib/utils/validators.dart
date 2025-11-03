class Validators {
  static bool isValidNome(String nome) {
    return nome.trim().length >= 2 && nome.trim().length <= 100;
  }

  static bool isValidMatricula(String matricula) {
    return matricula.trim().isNotEmpty && matricula.trim().length <= 20;
  }

  static bool isValidSalario(double salario) {
    return salario > 0 && salario <= 1000000;
  }

  static bool isValidTipo(String tipo) {
    return ['Gerente', 'Desenvolvedor', 'Estagiario'].contains(tipo);
  }

  static String? validateNome(String? nome) {
    if (nome == null || nome.isEmpty) {
      return 'Nome é obrigatório';
    }
    if (!isValidNome(nome)) {
      return 'Nome deve ter entre 2 e 100 caracteres';
    }
    return null;
  }

  static String? validateMatricula(String? matricula) {
    if (matricula == null || matricula.isEmpty) {
      return 'Matrícula é obrigatória';
    }
    if (!isValidMatricula(matricula)) {
      return 'Matrícula deve ter até 20 caracteres';
    }
    return null;
  }

  static String? validateSalario(String? salario) {
    if (salario == null || salario.isEmpty) {
      return 'Salário é obrigatório';
    }
    try {
      final value = double.parse(salario);
      if (!isValidSalario(value)) {
        return 'Salário deve ser maior que zero e menor que R\$ 1.000.000';
      }
      return null;
    } catch (e) {
      return 'Salário deve ser um número válido';
    }
  }
}