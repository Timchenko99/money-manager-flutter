import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences{
  static final UserPreferences _instance = UserPreferences._ctor();

  factory UserPreferences(){
    return _instance;
  }

  UserPreferences._ctor();

  SharedPreferences _prefs;

  init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  get monthBalance{
    return (_prefs.getInt("monthBalance") ?? 100);
  }

  set monthBalance(int newValue){
    _prefs.setInt("monthBalance", newValue);
  }

  get currentBalance{
    return (_prefs.getInt("currentBalance") ?? 50);
  }

  set currentBalance(int newValue){
    _prefs.setInt("currentBalance", newValue);
  }

}