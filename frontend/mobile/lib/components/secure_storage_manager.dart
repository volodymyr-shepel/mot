import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageManager {
  static final SecureStorageManager _instance = SecureStorageManager._internal();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  factory SecureStorageManager() {
    return _instance;
  }

  SecureStorageManager._internal();

  // Store a key-value pair securely
  Future<void> saveData(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  // Retrieve a value using the key
  Future<String?> getData(String key) async {
    return await _secureStorage.read(key: key);
  }

  // Delete a key-value pair
  Future<void> deleteData(String key) async {
    await _secureStorage.delete(key: key);
  }

  // Clear all stored data
  Future<void> clearAll() async {
    await _secureStorage.deleteAll();
  }
}
