import 'package:flutter/material.dart';

class UiUtils {
  static void showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).snackBarTheme.backgroundColor,
        content: Text(
          msg,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  static void hideCurrentSnackBar(BuildContext context) =>
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
}
