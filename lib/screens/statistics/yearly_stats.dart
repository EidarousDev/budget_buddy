import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';

class YearlyStats extends StatefulWidget {
  final List<Map<String, Object>> groupedTransactionValues;

  const YearlyStats({
    super.key,
    required this.groupedTransactionValues,
  });

  @override
  _YearlyStatsState createState() => _YearlyStatsState();
}

class _YearlyStatsState extends State<YearlyStats> {
  // final List<double> weeklyData = [5.0, 6.5, 5.0, 7.5, 9.0, 11.5, 6.5];

  int touchedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.0),
            color: Theme.of(context).primaryColorDark, //Color(0xff81e5cd),
          ),
          margin: EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Analysis',
                style: TextStyle(
                    color: Theme.of(context)
                        .primaryColorLight, //Color(0xff0f4a3c),
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                'Monthly Analysis',
                style: TextStyle(
                    color: Theme.of(context)
                        .primaryColorLight, //const Color(0xff379982),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 25,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: BarChart(
                    mainBarData(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  BarChartGroupData _buildBar(
    int x,
    double y, {
    bool isTouched = false,
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: isTouched ? Theme.of(context).primaryColor : Colors.white,
          width: 22,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 20,
            color: Theme.of(context).primaryColorLight, //[Color(0xff72d8bf)],
          ),
        ),
      ],
    );
  }

  List<BarChartGroupData> _buildAllBars() {
    return List.generate(
      widget.groupedTransactionValues.length,
      (index) => _buildBar(
          index,
          double.parse((widget.groupedTransactionValues[index]['amount'] ?? 0)
              .toString()),
          isTouched: index == touchedIndex),
    );
  }

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: _buildBarTouchData(),
      titlesData: _buildAxes(),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: _buildAllBars(),
    );
  }

  FlTitlesData _buildAxes() {
    return FlTitlesData(
      // Build X axis.
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, meta) {
              switch (value.toInt()) {
                case 0:
                  return Text(widget.groupedTransactionValues[0]['month']
                      .toString()
                      .substring(0, 3));
                case 1:
                  return Text(widget.groupedTransactionValues[1]['month']
                      .toString()
                      .substring(0, 3));
                case 2:
                  return Text(widget.groupedTransactionValues[2]['month']
                      .toString()
                      .substring(0, 3));
                case 3:
                  return Text(widget.groupedTransactionValues[3]['month']
                      .toString()
                      .substring(0, 3));
                case 4:
                  return Text(widget.groupedTransactionValues[4]['month']
                      .toString()
                      .substring(0, 3));
                case 5:
                  return Text(widget.groupedTransactionValues[5]['month']
                      .toString()
                      .substring(0, 3));
                default:
                  return Text('');
              }
            }),
      ),
      // Build Y axis.
      leftTitles:
          AxisTitles(sideTitles: SideTitles(getTitlesWidget: (value, meta) {
        return Text(value.toString());
      })),
    );
  }

  BarTouchData _buildBarTouchData() {
    return BarTouchData(
      touchTooltipData: BarTouchTooltipData(
        getTooltipColor: (data) => Colors.blueGrey,
        getTooltipItem: (group, groupIndex, rod, rodIndex) {
          String weekDay = '';
          switch (group.x.toInt()) {
            case 0:
              weekDay = widget.groupedTransactionValues[0]['month'].toString();
              break;
            case 1:
              weekDay = widget.groupedTransactionValues[1]['month'].toString();
              break;
            case 2:
              weekDay = widget.groupedTransactionValues[2]['month'].toString();
              break;
            case 3:
              weekDay = widget.groupedTransactionValues[3]['month'].toString();
              break;
            case 4:
              weekDay = widget.groupedTransactionValues[4]['month'].toString();
              break;
            case 5:
              weekDay = widget.groupedTransactionValues[5]['month'].toString();
              break;
          }
          return BarTooltipItem(
            weekDay + '\n' + (rod.toY).toString(),
            TextStyle(color: Colors.yellow),
          );
        },
      ),
      touchCallback: (event, barTouchResponse) {
        setState(() {
          if (barTouchResponse?.spot != null &&
              event is! FlPanEndEvent &&
              event is! FlLongPressEnd) {
            touchedIndex = barTouchResponse!.spot!.touchedBarGroupIndex;
          } else {
            touchedIndex = -1;
          }
        });
      },
    );
  }
}
