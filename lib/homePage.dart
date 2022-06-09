import 'package:expense_app/models/transaction.dart';
import 'package:expense_app/widgets/NewTransactionWidget.dart';
import 'package:expense_app/widgets/WeeklyExpensesWidget.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';

import '../widgets/ExpenseList.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Transaction> _expenseList = [];

  List<Transaction> get _recentTransaction {
    return _expenseList.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  addTransaction(String title, String amount, DateTime date) {
    setState(() {
      _expenseList.add(Transaction(
          id: Uuid().v4(),
          amount: double.parse(amount),
          date: date,
          title: title));
    });
  }

  showAddTransactionModal(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (modalCtx) {
          return NewTransactionWidget(addTransaction);
        });
  }

  deleteTransaction(String id) {
    setState(() {
      _expenseList.removeWhere((element) => element.id == id);
    });
  }

  bool _showChart = false;

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(
        "expense app",
      ),
      actions: [
        IconButton(
          splashRadius: 20,
          onPressed: () {
            showAddTransactionModal(context);
          },
          icon: Icon(Icons.add),
        ),
      ],
    );
    final _chartWidget = Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.3,
        child: WeeklyExpenseWidget(_recentTransaction));

    final _txList = Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.7,
        child: ExpenseList(_expenseList, deleteTransaction));
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      appBar: appBar,
      body: Container(
        height: (MediaQuery.of(context).size.height -
            appBar.preferredSize.height -
            MediaQuery.of(context).padding.top),
        child: Column(
          children: [
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Show Chart"),
                  Switch.adaptive(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                  )
                ],
              ),
            if (!isLandscape)
              Container(
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.3,
                  child: WeeklyExpenseWidget(_recentTransaction)),
            if (!isLandscape) _txList,
            if (isLandscape)
              _showChart
                  ? Container(
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.7,
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: WeeklyExpenseWidget(_recentTransaction))
                  : _txList,
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddTransactionModal(context);
        },
        child: Icon(
          Icons.add,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
