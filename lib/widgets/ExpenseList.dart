import 'package:expense_app/models/transaction.dart';
import 'package:expense_app/widgets/TransactionWidget.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  late List<Transaction> _expenseList;
  Function deleteTransaction;

  ExpenseList(this._expenseList, this.deleteTransaction) {}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _expenseList.length == 0
          ? Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "No expense added yet",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.asset(
                      "assets/images/emptyicon.png",
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: _expenseList.length,
              itemBuilder: (context, index) {
                return TransactionWidget(
                    _expenseList[index], deleteTransaction);
              },
            ),
    );
  }
}
