import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

import '../models/pie_data.dart';
import '../models/transaction.dart';
import '../providers/transactions_provider.dart';

class Utils {
  static List<PieData> pieChartData(List<Transaction> trx) {
    int total = Transactions().getTotal(trx);
    List<Map<String, Object>> finalData = sortedPieData(trx);
    RandomColor _randomColor = RandomColor();

    List<PieData> data = [];

    finalData.forEach((element) {
      Color _color =
          _randomColor.randomColor(colorBrightness: ColorBrightness.primary);
      data.add(
        PieData(
          name: element['title'].toString(),
          percent: (((element['amount'] as int) * 100) / total)
              .round()
              .ceilToDouble(),
          color: _color,
          price: int.parse(element['amount'].toString()),
        ),
      );
    });

    return data;
  }

  // Sortig Data According To Category vise
  static List<Map<String, Object>> sortedPieData(List<Transaction> trx) {
    List<Map<String, Object>> finalList = [];

    for (var i = 0; i < trx.length; i++) {
      var index = finalList
          .indexWhere((element) => element['title'] == trx[i].category);

      if (index != -1) {
        finalList[index]['amount'] =
            (finalList[index]['amount'] as int) + trx[i].amount;
      } else {
        finalList.add({
          'title': trx[i].category,
          'amount': trx[i].amount,
        });
      }
    }
    return finalList;
  }
}
