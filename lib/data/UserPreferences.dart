import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instance = UserPreferences._ctor();

  factory UserPreferences(){
    return _instance;
  }

  UserPreferences._ctor();

  SharedPreferences _prefs;

  init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  get isFirstBoot{
    return (_prefs.getBool("isFirstBoot") ?? true);
  }

  set isFirstBoot(bool newValue){
    _prefs.setBool("isFirstBoot", newValue);
  }

  get targetAmount{
    return (_prefs.getDouble("targetAmount") ?? 0);
  }

  set targetAmount(double newValue){
    _prefs.setDouble("targetAmount", newValue);

  }

  get dailyBudget{
    return (_prefs.getDouble("dailyBudget") ?? 1);
  }

  set dailyBudget(double newValue){
    _prefs.setDouble("dailyBudget", newValue);
  }

  get goal{
    return (_prefs.getString("goal") ?? "None");
  }

  set goal(String newValue){
    _prefs.setString("goal", newValue);
  }

}