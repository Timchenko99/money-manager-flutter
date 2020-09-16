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

  get dailyGoal{
    return (_prefs.getInt("dailyGoal") ?? 1);
  }

  set dailyGoal(int newValue){
    _prefs.setInt("dailyGoal", newValue);
  }


  get goal{
    return (_prefs.getInt("goal") ?? "None");
  }

  set goal(int newValue){
    _prefs.setInt("goal", newValue);
  }

}