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
  //dispose a memoriából való törlést szolgálja TextEditingController-nél mindig szükséges 
  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
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
              ElevatedButton(
                  onPressed: () {
                    print(_titleController);
                  },
                  child: const Text('Save Expense'))
            ],
          )
        ],
      ),
    );
  }
}
