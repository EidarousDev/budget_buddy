import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../core/app_strings.dart';
import '../../core/utils.dart';
import '../../models/pie_data.dart';
import '../../providers/settings_provider.dart';
import '../../providers/transactions_provider.dart';
import '../../widgets/no_trancaction.dart';
import '../../widgets/savings_progress_indicator.dart';
import '../../widgets/transaction_list_items.dart';
import '../statistics/pie_chart.dart';
import 'widgets/show_chart_switch.dart';

class DailySpendings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Consumer<Transactions>(builder: (context, provider, child) {
        final dailyTrans = provider.dailyTransactions();
        final List<PieData> dailyData = Utils.pieChartData(dailyTrans);
        final trxData = Provider.of<Transactions>(context, listen: false);
        final Function deleteFn =
            Provider.of<Transactions>(context, listen: false).deleteTransaction;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
                padding: const EdgeInsets.only(
                    right: 15, top: 10, bottom: 10, left: 15),
                color: Theme.of(context).primaryColorLight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${S.total}:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "₹${trxData.getTotal(provider.dailyTransactions())}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    ShowChartSwitch(
                      onChanged: (val) {
                        provider.showDailySpendingChart = val;
                      },
                      value: provider.showDailySpendingChart,
                    ),
                  ],
                )),
            dailyTrans.isEmpty
                ? NoTransactions()
                : (provider.showDailySpendingChart
                    ? MyPieChart(pieData: dailyData)
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (ctx, index) {
                          return TransactionListItems(
                              trx: dailyTrans[index], dltTrxItem: deleteFn);
                        },
                        itemCount: dailyTrans.length,
                      ))
          ],
        );
      }),
    );
  }
}
