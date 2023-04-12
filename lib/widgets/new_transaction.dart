import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  const NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  @required
  final TextEditingController _titleControler = TextEditingController();

  @required
  final TextEditingController _amountControler = TextEditingController();

  late DateTime _selectedDate = DateTime.now();

  void _submitData() {
    final entredTitle = _titleControler.text;
    final enteredAmount = double.parse(_amountControler.text);

    if (entredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null)
      return;

    widget.addTx(
      _titleControler.text,
      double.parse(_amountControler.text),
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2023),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) return;

      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10,
              left: 10,
              right: 10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleControler,
              keyboardType: TextInputType.name,
              onSubmitted: (_) => {_submitData()},
              // onChanged: (value) {
              //   titleInput = value;
              // },
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: _amountControler,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => {_submitData()},
              // onChanged: (value) {
              //   amoutInput = value;
              // },
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(_selectedDate == null
                        ? 'No Date Chosen!'
                        : 'Picked Date: ${DateFormat.yMMMd().format(_selectedDate)}'),
                  ),
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStatePropertyAll(
                          Theme.of(context).primaryColor),
                    ),
                    onPressed: _presentDatePicker,
                    child: Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _submitData,
              style: ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.onPrimary),
                  backgroundColor:
                      MaterialStatePropertyAll(Theme.of(context).primaryColor)),
              child: const Text('Add Transaction'),
            )
          ]),
        ),
      ),
    );
  }
}
