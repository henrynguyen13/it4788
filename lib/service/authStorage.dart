import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  final storage = const FlutterSecureStorage();
  Future<void> saveToken(String token) async {
    await storage.write(key: "token", value: token);
  }

  Future<void> saveEmail(String email) async {
    await storage.write(key: "email", value: email);
  }

  Future<void> saveUsername(String username) async {
    await storage.write(key: "username", value: username);
  }

  Future<void> saveVerifyCode(String verifyCode) async {
    await storage.write(key: "verify_code", value: verifyCode);
  }

  Future<void> saveAvatar(String avatar) async {
    await storage.write(key: "avatar", value: avatar);
  }

  Future<void> saveUserId(String userId) async {
    await storage.write(key: "user_id", value: userId);
  }

  Future<void> saveCoins(String coins) async {
    await storage.write(key: "coins", value: coins);
  }

  Future<String?> getToken() async {
    return await storage.read(key: "token");
  }

  Future<String?> getEmail() async {
    return await storage.read(key: "email");
  }

  Future<String?> getUsername() async {
    return await storage.read(key: "username");
  }

  Future<String?> getVerifyCode() async {
    return await storage.read(key: "verify_code");
  }

  Future<String?> setAvatar() async {
    return await storage.read(key: "avatar");
  }

  Future<String?> getAvatar() async {
    return await storage.read(key: "avatar");
  }

  void deleteToken() async {
    await storage.delete(key: "token");
  }

  Future<String?> getUserId() async {
    return await storage.read(key: "user_id");
  }

  Future<String?> getCoins() async {
    return await storage.read(key: "coins");
  }
}
