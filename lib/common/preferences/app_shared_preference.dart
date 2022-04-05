import 'localization.dart';
import 'user_data.dart';

abstract class AppSharedPreference {
  const AppSharedPreference();

  //an object to save user data in shared preferences
  static const UserDataSharedPreference userData = UserDataSharedPreference();

  //an object to save last selected language
  static const LocalizationSharedPreference localization =
      LocalizationSharedPreference();

  //to clear all app shared preferences
  static Future<void> clearAllData() async {
    await userData.clearData();
    await localization.clearData();
  }
}
