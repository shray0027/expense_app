import 'package:expense_app/models/transaction.dart';
import 'package:expense_app/widgets/ExpenseChartBar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeeklyExpenseWidget extends StatelessWidget {
  final List<Transaction> _weeklyExpenses;

  WeeklyExpenseWidget(this._weeklyExpenses) {
    print(_weeklyExpenses);
  }

  List<Map<String, Object>>? get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      var totalSum = 0.0;
      for (var i = 0; i < _weeklyExpenses.length; i++) {
        if (_weeklyExpenses[i].date.day == weekDay.day &&
            _weeklyExpenses[i].date.month == weekDay.month &&
            _weeklyExpenses[i].date.year == weekDay.year) {
          totalSum += _weeklyExpenses[i].amount;
        }
      }
      return {'day': DateFormat.E().format(weekDay), 'amount': totalSum};
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues!.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 20,
      ),
      child: Card(
        elevation: 8,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.white),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: groupedTransactionValues != null
                ? groupedTransactionValues!.map((data) {
                    return Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: ExpenseChartBarWidget(
                          (data['day'] as String),
                          (data['amount'] as double),
                          totalSpending == 0
                              ? 0.0
                              : (data['amount'] as double) / totalSpending),
                    );
                  }).toList()
                : [],
          ),
        ),
      ),
    );
  }
}
