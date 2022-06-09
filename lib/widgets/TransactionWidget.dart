import 'package:expense_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionWidget extends StatelessWidget {
  late Transaction _trx;
  Function deleteTransaction;
  TransactionWidget(@required Transaction trx, this.deleteTransaction) {
    _trx = trx;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      height: 80,
      child: Center(
        child: ListTile(
          tileColor: Colors.blueGrey,
          leading: CircleAvatar(
            radius: 50,
            child: FittedBox(
                fit: BoxFit.contain,
                child: Text("\$${_trx.amount.toStringAsFixed(1)}")),
          ),
          title: Text(
            _trx.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            DateFormat.yMd().format(_trx.date),
          ),
          trailing: MediaQuery.of(context).size.width > 460
              ? TextButton.icon(
                  onPressed: () => deleteTransaction(_trx.id),
                  icon: Icon(Icons.delete),
                  label: Text("delete"),
                  style: TextButton.styleFrom(
                      primary: Colors.red, backgroundColor: Colors.white),
                )
              : GestureDetector(
                  onTap: () => deleteTransaction(_trx.id),
                  child: CircleAvatar(
                    backgroundColor: Colors.red,
                    child: Icon(
                      Icons.delete,
                      color: Colors.black,
                    ),
                  ),
                ),
          textColor: Colors.white,
        ),
      ),
    );
  }
}
