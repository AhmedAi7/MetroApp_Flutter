

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
  setUser(String fullname,String email,String password,String phone_number,String date_of_birth, String balance)async
  {
    final prefs=await SharedPreferences.getInstance();
    prefs.setString("fullname", fullname);
    prefs.setString("email", email);
    prefs.setString("password", password);
    prefs.setString("phone_number", phone_number);
    prefs.setString("date_of_birth", date_of_birth);
    prefs.setString("balance", balance);
  }
}