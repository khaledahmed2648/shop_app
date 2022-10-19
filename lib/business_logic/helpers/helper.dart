 import 'package:shared_preferences/shared_preferences.dart';

class Helper{
  static late  SharedPreferences sharedPreferences;

  static init()async {
    sharedPreferences= await SharedPreferences.getInstance();
  }


}
 String? token;