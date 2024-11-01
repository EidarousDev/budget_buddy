import 'package:flutter/material.dart';

import '../core/app_strings.dart';

/// ====== Mahmoud Eidarous ====== ///

class SavingsProgressIndicator extends StatefulWidget {
  final double value;
  const SavingsProgressIndicator({super.key, required this.value});

  @override
  State<SavingsProgressIndicator> createState() =>
      _SavingsProgressIndicatorState();
}

class _SavingsProgressIndicatorState extends State<SavingsProgressIndicator>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 3),
    )..addListener(() {
        if (controller.value == widget.value) {
          controller.stop();
        }
        setState(() {});
      });
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('value = ${widget.value}');
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        if (widget.value >= 0.9 && widget.value < 1) ...[
          const Text(
            S.almostThere,
            style: TextStyle(fontSize: 20),
          ),
        ],
        LinearProgressIndicator(value: controller.value),
      ],
    );
  }
}
