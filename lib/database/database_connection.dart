import 'package:mysql1/mysql1.dart';
import 'database_config.dart';

class DatabaseConnection {
  static MySqlConnection? _connection;
  
  static Future<MySqlConnection> get connection async {
    if (_connection == null) {
      await _initialize();
    }
    return _connection!;
  }
  
  static Future<void> _initialize() async {
    final settings = ConnectionSettings(
      host: DatabaseConfig.host,
      port: DatabaseConfig.port,
      user: DatabaseConfig.user,
      password: DatabaseConfig.password,
      db: DatabaseConfig.database,
    );
    
    _connection = await MySqlConnection.connect(settings);
  }
  
  static Future<void> close() async {
    if (_connection != null) {
      await _connection!.close();
      _connection = null;
    }
  }
  
  static Future<bool> testConnection() async {
    try {
      final conn = await connection;
      await conn.query('SELECT 1');
      return true;
    } catch (e) {
      return false;
    }
  }
}