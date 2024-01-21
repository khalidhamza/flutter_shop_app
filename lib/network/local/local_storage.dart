import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage
{
  static SharedPreferences? storage;

  static Future<SharedPreferences?> init() async {
    storage = await SharedPreferences.getInstance();
    return storage;
  }

  static Future<bool?> setData({required String key, required dynamic value}) async
  {
    print("setDataType");
    print(value.runtimeType);

    if(value is String){
      return storage?.setString(key, value);
    }

    else if(value is int){
      return storage?.setInt(key, value);
    }

    else if(value is double){
      return storage?.setDouble(key, value);
    }

    else if(value is bool){
      return storage?.setBool(key, value);
    }

    else if(value is List<String>){
      return storage?.setStringList(key, value);
    }
    else{
      return null;
    }
  }

  static Future<bool?> removeData({required String key}) async
  {
    return storage?.remove(key);
  }

  static bool? getBool({required String key})
  {
    return storage?.getBool(key);
  }

  static String? getString({required String key})
  {
    return storage?.getString(key);
  }

  static double? getDouble({required String key})
  {
    return storage?.getDouble(key);
  }

  static List<String>? getList({required String key})
  {
    return storage?.getStringList(key);
  }
}