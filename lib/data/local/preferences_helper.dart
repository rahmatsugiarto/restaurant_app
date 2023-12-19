import 'package:restaurant_app/common/constant/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  Future<bool> get isNotificationActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(AppConstant.notificationPrefKey) ?? false;
  }

  void setNotification(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(AppConstant.notificationPrefKey, value);
  }
}
