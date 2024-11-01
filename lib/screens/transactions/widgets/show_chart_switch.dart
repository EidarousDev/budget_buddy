import 'package:flutter/material.dart';

import '../../../core/app_strings.dart';

class ShowChartSwitch extends StatelessWidget {
  final bool value;
  final Function(bool value) onChanged;
  const ShowChartSwitch(
      {super.key, required this.onChanged, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          S.showChart,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        Switch.adaptive(
          activeColor: Theme.of(context).canvasColor,
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
