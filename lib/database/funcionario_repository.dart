import 'database_connection.dart';
import '../models/funcionario.dart';

class FuncionarioRepository {
  static Future<int> create(Funcionario funcionario) async {
    final conn = await DatabaseConnection.connection;
    final result = await conn.query(
      'INSERT INTO funcionarios (nome, matricula, salario_base, tipo) VALUES (?, ?, ?, ?)',
      [funcionario.nome, funcionario.matricula, funcionario.salarioBase, funcionario.tipo],
    );
    return result.insertId!;
  }

  static Future<List<Funcionario>> findAll() async {
    final conn = await DatabaseConnection.connection;
    final results = await conn.query('SELECT * FROM funcionarios ORDER BY id');
    
    return results.map((row) {
      return Funcionario.fromMap({
        'id': row['id'],
        'nome': row['nome'],
        'matricula': row['matricula'],
        'salario_base': row['salario_base'],
        'tipo': row['tipo'],
      });
    }).toList();
  }

  static Future<Funcionario?> findById(int id) async {
    final conn = await DatabaseConnection.connection;
    final results = await conn.query(
      'SELECT * FROM funcionarios WHERE id = ?',
      [id],
    );
    
    if (results.isEmpty) return null;
    
    final row = results.first;
    return Funcionario.fromMap({
      'id': row['id'],
      'nome': row['nome'],
      'matricula': row['matricula'],
      'salario_base': row['salario_base'],
      'tipo': row['tipo'],
    });
  }

  static Future<Funcionario?> findByMatricula(String matricula) async {
    final conn = await DatabaseConnection.connection;
    final results = await conn.query(
      'SELECT * FROM funcionarios WHERE matricula = ?',
      [matricula],
    );
    
    if (results.isEmpty) return null;
    
    final row = results.first;
    return Funcionario.fromMap({
      'id': row['id'],
      'nome': row['nome'],
      'matricula': row['matricula'],
      'salario_base': row['salario_base'],
      'tipo': row['tipo'],
    });
  }

  static Future<void> update(Funcionario funcionario) async {
    final conn = await DatabaseConnection.connection;
    await conn.query(
      'UPDATE funcionarios SET nome = ?, matricula = ?, salario_base = ?, tipo = ? WHERE id = ?',
      [funcionario.nome, funcionario.matricula, funcionario.salarioBase, funcionario.tipo, funcionario.id],
    );
  }

  static Future<void> delete(int id) async {
    final conn = await DatabaseConnection.connection;
    await conn.query(
      'DELETE FROM funcionarios WHERE id = ?',
      [id],
    );
  }

  static Future<int> count() async {
    final conn = await DatabaseConnection.connection;
    final result = await conn.query('SELECT COUNT(*) as total FROM funcionarios');
    return result.first['total'] as int;
  }
}