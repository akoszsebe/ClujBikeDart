import 'package:shared_preferences/shared_preferences.dart';

class LocalDb {
  ///
  /// Instantiation of the SharedPreferences library
  ///
  static final String _favoriteIds = "favorite_ids";
  static final String _startUpTab = "start_up_tab";

  static Future<List<String>> getFavoriteIds() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_favoriteIds) ?? List<String>();
  }

  static Future<bool> setfavoriteId(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteIds =
        prefs.getStringList(_favoriteIds) ?? List<String>();
    favoriteIds.add(value);
    return prefs.setStringList(_favoriteIds, favoriteIds);
  }

  static Future<bool> removefavoriteId(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteIds =
        prefs.getStringList(_favoriteIds) ?? List<String>();
    favoriteIds.remove(value);
    return prefs.setStringList(_favoriteIds, favoriteIds);
  }

  static Future<bool> containsFavoriteId(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoriteIds =
        prefs.getStringList(_favoriteIds) ?? List<String>();
    return favoriteIds.contains(value);
  }

  static Future<int> getStartUpTab() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_startUpTab) ?? 0;
  }

   static Future<bool> setStartUpTab(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(_startUpTab, value);
  }
}
