import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactionWidget extends StatefulWidget {
  final Function addTransaction;

  NewTransactionWidget(this.addTransaction) {}

  @override
  State<NewTransactionWidget> createState() => _NewTransactionWidgetState();
}

class _NewTransactionWidgetState extends State<NewTransactionWidget> {
  TextEditingController amountController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  DateTime? selectedDate = null;

  submitData(BuildContext context) {
    if (amountController.text.trim() == "" ||
        titleController.text.trim() == "" ||
        double.parse(amountController.text.trim()) <= 0 ||
        selectedDate == null) {
      return;
    }
    widget.addTransaction(titleController.text.trim(),
        amountController.text.trim(), selectedDate);
    Navigator.of(context).pop();
  }

  presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        child: Padding(
          padding: EdgeInsets.only(
              left: 8,
              top: 8,
              right: 8,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            TextField(
              controller: titleController,
              onSubmitted: (_) => submitData(context),
              decoration: InputDecoration(
                labelText: "Enter title",
              ),
            ),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Enter amount",
              ),
              onSubmitted: (_) => submitData(context),
            ),
            Container(
              height: 70,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  selectedDate == null
                      ? Text("No choosen date")
                      : Text(
                          'choosen date : ${DateFormat.yMd().format(selectedDate!)} ',
                          style: TextStyle(fontSize: 16),
                        ),
                  TextButton(
                    onPressed: presentDatePicker,
                    child: Text(
                      "Choose date",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => submitData(context),
              child: Text(
                "Add transaction",
              ),
            )
          ]),
        ),
      ),
    );
  }
}
