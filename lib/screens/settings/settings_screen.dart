import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/app_strings.dart';
import '../../core/ui_utils.dart';
import '../../providers/settings_provider.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings-screen';

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          S.settings,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        backgroundColor: Colors.white10,
      ),
      body: Consumer<SettingsProvider>(builder: (context, provider, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              right: 20,
              left: 20,
              top: 30,
              bottom: (MediaQuery.of(context).viewInsets.bottom) + 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: S.salaryAmount),
                  //onChanged: (value) => inputTitle = value,
                  controller: provider.salaryAmountController,
                ),
                SizedBox(height: 10),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: S.savingsGoalAmount,
                  ),
                  //onChanged: (value) => inputAmount = value,
                  controller: provider.savingsGoalAmountController,
                ),
                SizedBox(height: 30),
                MaterialButton(
                  child: const Text(S.saveChanges),
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).buttonTheme.colorScheme?.primary,
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    provider.saveChanges(onError: (msg) {
                      UiUtils.hideCurrentSnackBar(context);
                      UiUtils.showSnackBar(context, msg);
                    }, onSuccess: () {
                      UiUtils.hideCurrentSnackBar(context);
                      UiUtils.showSnackBar(context, S.dataSavedSuccessfully);
                    });
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
