import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  final storage = const FlutterSecureStorage();
  Future<void> saveToken(String token) async {
    await storage.write(key: "token", value: token);
    print(storage);
  }

  Future<void> saveEmail(String email) async {
    await storage.write(key: "email", value: email);
    print(storage);
  }

  Future<void> saveVerifyCode(String verifyCode) async {
    await storage.write(key: "verify_code", value: verifyCode);
    print(storage);
  }

  Future<String?> getToken() async {
    return await storage.read(key: "token");
  }

  Future<String?> getEmail() async {
    return await storage.read(key: "email");
  }

  Future<String?> getVerifyCode() async {
    return await storage.read(key: "verify_code");
  }

  void deleteToken() async {
    await storage.delete(key: "token");
  }
}
