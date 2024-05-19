import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
// var _enteredTitle = '';
//
// void _saveTitleInput(String inputValue) {
//   _enteredTitle = inputValue;
// }

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  //dispose a memoriából való törlést szolgálja TextEditingController-nél mindig szükséges
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

 void _presentDatePicker()  {
  final now = DateTime.now();
  final firstDate = DateTime(now.year -1, now.month,now.day);

    showDatePicker(context: context, initialDate: now ,firstDate: firstDate, lastDate: now);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            //onChanged: _saveTitleInput,
            maxLength: 50,
            //Billentyüzet fajta megnyitás
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  //onChanged: _saveTitleInput,
                  maxLength: 50,
                  //Billentyüzet fajta megnyitás
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    //number dollár pénznem mutatása
                    prefixText: '\$ ',
                    label: Text('Amount'),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
               Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Selected Date'),
                   IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              )
            ],
          ),
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              ElevatedButton(
                onPressed: () {
                  print(_titleController);
                  print(_amountController);
                },
                child: const Text('Save Expense'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
