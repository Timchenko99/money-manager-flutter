// import 'package:shared_preferences/shared_preferences.dart';
//
// class UserPreferences {
//   static final UserPreferences _instance = UserPreferences._ctor();
//
//   factory UserPreferences(){
//     return _instance;
//   }
//
//   UserPreferences._ctor();
//
//   SharedPreferences _prefs;
//
//   init() async {
//     _prefs = await SharedPreferences.getInstance();
//   }
//
//   get isFirstBoot{
//     return (_prefs.getBool("isFirstBoot") ?? true);
//   }
//
//   set isFirstBoot(bool newValue){
//     _prefs.setBool("isFirstBoot", newValue);
//   }
//
//   get targetAmount{
//     return (_prefs.getInt("targetAmount") ?? 0);
//   }
//
//   set targetAmount(int newValue){
//     _prefs.setInt("targetAmount", newValue);
//
//   }
//
//   get dailyBudget{
//     return (_prefs.getInt("dailyBudget") ?? 1);
//   }
//
//   set dailyBudget(int newValue){
//     _prefs.setInt("dailyBudget", newValue);
//   }
//
//   get goal{
//     return (_prefs.getString("goal") ?? "None");
//   }
//
//   set goal(String newValue){
//     _prefs.setString("goal", newValue);
//   }
//
// }