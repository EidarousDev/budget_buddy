import 'dart:collection';

import 'package:flutter/cupertino.dart';

import '../DBhelp/dbhelper.dart';
import '../core/app_strings.dart';
import '../models/settings_model.dart';

/// ====== Mahmoud Eidarous ====== ///
class SettingsProvider extends ChangeNotifier {
  final TextEditingController salaryAmountController = TextEditingController();
  final TextEditingController savingsGoalAmountController =
      TextEditingController();
  Settings? _settings;

  Settings? get settings => _settings;

  Future<void> fetchSettings() async {
    final settings = await DBHelper.fetchSettings();
    debugPrint('settings = ${settings.toString()}');
    if (settings.isNotEmpty) {
      _settings = settings[0];
      salaryAmountController.text = settings[0].salaryAmount.toString();
      savingsGoalAmountController.text = settings[0].savingAmount.toString();
      notifyListeners();
    }
  }

  void saveChanges(
      {required Function() onSuccess, required Function(String msg) onError}) {
    if (salaryAmountController.text.trim().isEmpty ||
        (int.parse(salaryAmountController.text)) <= 0) {
      onError(S.inValidSalary);
      return;
    }
    if (int.parse(salaryAmountController.text) <
        int.parse(savingsGoalAmountController.text)) {
      onError(S.salaryLessThanSavingError);
      return;
    }
    updateSettings(Settings(
        salaryAmount: int.parse(salaryAmountController.text),
        savingAmount: int.parse(savingsGoalAmountController.text)));
    onSuccess();
  }

  void updateSettings(Settings settings) {
    DBHelper.updateSettings(settings);
  }

  void reset() {
    salaryAmountController.clear();
    savingsGoalAmountController.clear();
    notifyListeners();
  }
}
