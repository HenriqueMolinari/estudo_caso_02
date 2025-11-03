class DatabaseConfig {
  static const String host = 'localhost';
  static const int port = 3306;
  static const String user = 'root';
  static const String password = 'unifeob@123';
  static const String database = 'estudocaso2_db';
  
  static Map<String, dynamic> toMap() {
    return {
      'host': host,
      'port': port,
      'user': user,
      'password': password,
      'database': database,
    };
  }
}