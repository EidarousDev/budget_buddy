import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionListItems extends StatefulWidget {
  final Transaction trx;
  final Function dltTrxItem;

  const TransactionListItems({
    super.key,
    required this.trx,
    required this.dltTrxItem,
  });
  @override
  _TransactionListItemsState createState() => _TransactionListItemsState();
}

class _TransactionListItemsState extends State<TransactionListItems> {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              padding: const EdgeInsets.all(8.0),
              child: Text("₹${widget.trx.amount}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColorDark,
                  )),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Theme.of(context).primaryColor,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.trx.title}",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text(
                  DateFormat.yMMMd().format(widget.trx.date),
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                )
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).disabledColor,
                    ),
                    onPressed: () => showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => AlertDialog(
                        title: const Text('Are you sure'),
                        content: const Text(
                            'Do you really want to delete this transaction?'),
                        actions: [
                          MaterialButton(
                              onPressed: () {
                                widget.dltTrxItem(widget.trx.id);
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Yes',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context).primaryColor),
                              )),
                          MaterialButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'No',
                                style: TextStyle(fontSize: 20),
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
