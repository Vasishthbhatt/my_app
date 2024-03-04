import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction {
  //Keys
  static String userLoggedInKey = "UserLoggeInKey";
  static String userNameKey = 'UserNameKey';
  static String userEmailKey = 'UserEmailKey';

  static Future<bool?> getUserLoggedInStatus() async {
    SharedPreferences sf = await SharedPreferences.getInstance();
    return sf.getBool(userLoggedInKey);
  }
}
