import 'package:flutter/material.dart';

import '../../models/pie_data.dart';

class IndicatorsWidget extends StatelessWidget {
  final List<PieData> pieData;

  const IndicatorsWidget({super.key, required this.pieData});

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: pieData
            .map(
              (data) => Container(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: buildIndicator(
                    color: data.color,
                    text: data.name,
                  )),
            )
            .toList(),
      );

  Widget buildIndicator({
    required Color color,
    required String text,
    double size = 16,
    Color textColor = const Color(0xff000000),
  }) =>
      Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          )
        ],
      );
}
