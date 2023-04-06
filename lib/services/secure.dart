import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Endpoints {
  String host = "https://api.cloudflare.com";

  String version = "client/v4";

  String get zones => "$host/$version/zones";

  dnsRecords(zoneIdentifier){
    return "$zones/$zoneIdentifier/dns_records";
  }

}

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
