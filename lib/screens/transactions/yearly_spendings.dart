import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../core/utils.dart';
import '../../models/pie_data.dart';
import '../../providers/transactions_provider.dart';
import '../../widgets/no_trancaction.dart';
import '../../widgets/transaction_list_items.dart';
import '../statistics/pie_chart.dart';
import '../statistics/yearly_stats.dart';
import 'widgets/show_chart_switch.dart';

class YearlySpendings extends StatefulWidget {
  @override
  _YearlySpendingsState createState() => _YearlySpendingsState();
}

class _YearlySpendingsState extends State<YearlySpendings> {
  String _selectedYear = DateFormat('yyyy').format(DateTime.now());
  bool _showChart = false;
  late Transactions trxData;
  List<PieData> yearlyData = [];

  @override
  void initState() {
    super.initState();
    trxData = Provider.of<Transactions>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final deleteFn = Provider.of<Transactions>(context).deleteTransaction;

    final yearlyTrans = Provider.of<Transactions>(context, listen: false)
        .yearlyTransactions(_selectedYear);

    final List<PieData> yearlyData = Utils.pieChartData(yearlyTrans);

    final List<Map<String, Object>> groupTransFirstSixMonths = trxData
        .firstSixMonthsTransValues(yearlyTrans, int.parse(_selectedYear));
    final List<Map<String, Object>> groupTransLastSixMonths =
        trxData.lastSixMonthsTransValues(yearlyTrans, int.parse(_selectedYear));
    bool checkForEmpty(List<Map<String, Object>> groupTrans) {
      return groupTrans.every((element) {
        if (element['amount'] == 0) {
          return true;
        }
        return false;
      });
    }

    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        // mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.only(right: 15, left: 5, top: 5, bottom: 5),
            color: Theme.of(context).primaryColorLight,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    widgetToSelectYear(),
                    Text(
                      "₹${trxData.getTotal(yearlyTrans)}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                ShowChartSwitch(
                  onChanged: (val) {
                    setState(() {
                      _showChart = val;
                    });
                  },
                  value: _showChart,
                ),
              ],
            ),
          ),
          yearlyTrans.isEmpty
              ? NoTransactions()
              : _showChart
                  ? yearlyChart(
                      context,
                      yearlyData,
                      groupTransFirstSixMonths,
                      groupTransLastSixMonths,
                      checkForEmpty,
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, index) {
                        return TransactionListItems(
                            trx: yearlyTrans[index], dltTrxItem: deleteFn);
                      },
                      itemCount: yearlyTrans.length,
                    ),
        ],
      ),
    );
  }

  Row widgetToSelectYear() {
    return Row(
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.arrow_left),
          onPressed: int.parse(_selectedYear) == 0
              ? null
              : () {
                  setState(() {
                    _selectedYear = (int.parse(_selectedYear) - 1).toString();
                  });
                },
        ),
        Text(_selectedYear),
        IconButton(
          icon: const Icon(Icons.arrow_right),
          onPressed: _selectedYear == DateFormat('yyyy').format(DateTime.now())
              ? null
              : () {
                  setState(() {
                    _selectedYear = (int.parse(_selectedYear) + 1).toString();
                  });
                },
        ),
      ],
    );
  }

  Column yearlyChart(
    BuildContext context,
    List<PieData> yearlyData,
    List<Map<String, Object>> firstSixMonths,
    List<Map<String, Object>> lastSixMonths,
    Function checkForEmpty,
  ) {
    return Column(
      children: [
        Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          color: Theme.of(context).primaryColorDark,
          child: MyPieChart(pieData: yearlyData),
        ),
        checkForEmpty(firstSixMonths)
            ? Container()
            : YearlyStats(
                groupedTransactionValues: firstSixMonths,
              ),
        checkForEmpty(lastSixMonths)
            ? Container()
            : YearlyStats(
                groupedTransactionValues: lastSixMonths,
              ),
      ],
    );
  }
}
