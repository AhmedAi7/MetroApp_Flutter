

import 'package:shared_preferences/shared_preferences.dart';

class loginStatues
{
  readStatus() async
  {
    final prefs = await SharedPreferences.getInstance();
    final key= "status";
    final value =prefs.getBool(key) ?? false;
    return value;
  }
  writeStatus(bool status)async
  {
    final prefs = await SharedPreferences.getInstance();
    final key= "status";
    prefs.setBool(key, status);
  }
  static void writetoken(String value) async
  {
  final prefs= await SharedPreferences.getInstance();
  final key= "token";
  prefs.setString(key, value);
 }
  readtoken()async
  {
    final prefs=await SharedPreferences.getInstance();
    final key="token";
    final value=prefs.getString(key)??false;
    return value;
  }
}