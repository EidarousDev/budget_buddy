import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../models/pie_data.dart';
import '../../widgets/pie_chart_widgets/indicators_widget.dart';
import '../../widgets/pie_chart_widgets/pie_chart_sections.dart';

class MyPieChart extends StatefulWidget {
  final List<PieData> pieData;

  const MyPieChart({
    super.key,
    required this.pieData,
  });

  @override
  _MyPieChartState createState() => _MyPieChartState();
}

class _MyPieChartState extends State<MyPieChart> {
  int touchedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenWidht = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidht * 0.95,
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        children: <Widget>[
          Expanded(
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (event, pieTouchResponse) {
                    setState(() {
                      if (event is FlLongPressEnd || event is FlPanEndEvent) {
                        touchedIndex = -1;
                      } else {
                        touchedIndex = pieTouchResponse
                                ?.touchedSection?.touchedSectionIndex ??
                            0;
                      }
                    });
                  },
                ),
                borderData: FlBorderData(show: false),
                sectionsSpace: 0,
                centerSpaceRadius: 40,
                sections:
                    getSections(touchedIndex, widget.pieData, screenWidht),
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: IndicatorsWidget(
                  pieData: widget.pieData,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
