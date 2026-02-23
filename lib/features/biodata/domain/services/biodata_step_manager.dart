import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/utils/constants.dart';

class BiodataStepManager {
  static Future<void> setNextStep(String routePath) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.biodata.nextStep, routePath);
  }

  static Future<String?> getNextStep() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(AppConstants.biodata.nextStep);
  }

  static Future<void> clearNextStep() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.biodata.nextStep);
  }
}
