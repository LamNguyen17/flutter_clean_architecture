import 'package:shared_preferences/shared_preferences.dart';

class StorageGateway {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  setItem(String key, String value) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.setString(key, value);
  }

  getItem(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(key);
  }

  removeItem(String key) async {
    final SharedPreferences prefs = await _prefs;
    return prefs.remove(key);
  }
}
