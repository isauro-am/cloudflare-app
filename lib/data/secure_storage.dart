import 'package:flutter_secure_storage/flutter_secure_storage.dart';

StoreSecureData sotoreSecureData = StoreSecureData();

class SecureUserData {
  static const storage = FlutterSecureStorage();

  static Future setValue(key, value) async =>
      await storage.write(key: key, value: value);

  static Future<String?> getValue(key) async => await storage.read(key: key);

  static Future deletValue(key) async => await storage.delete(key: key);
}

class StoreSecureData {
  setData(key, value) async {
    try {
      await SecureUserData.storage.delete(key: value);
      await SecureUserData.setValue(key, value);
    } catch (e) {
      await SecureUserData.setValue(key, value);
    }
  }

  getData(key) async {
    return await SecureUserData.getValue(key);
  }

  delData(key) async {
    await SecureUserData.deletValue(key);
  }
}

/// The function checks if a token is defined in secure data storage and returns a boolean value
/// accordingly.
///
/// Returns:
///   The function `tokenDefined()` is returning a boolean value (`true` or `false`) based on whether
/// the token data is stored in the secure storage or not. If the token data is stored, it will return
/// `true`, otherwise it will return `false`.
tokenDefined() async {
  if (await sotoreSecureData.getData("token") != null) {
    return true;
  } else {
    return false;
  }
}
