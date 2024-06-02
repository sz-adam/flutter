import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  _NewItemState createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {

  final _formKey =GlobalKey<FormState>();

  void _saveItem(){
_formKey.currentState!.validate();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              //form specifikus widget Név
              TextFormField(
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Name'),
                ),
                //lehetővé teszi egy fügvény hozzáadását
                validator: (value) {
                  //ha az érték null vagy üres vagy nem egy üres karaktert(spacest) adtunk meg vagy nem lehet 50 karakternél több
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length > 50) {
                    return 'Must be between 1 and 50 character';
                  }
                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Quantity'),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        //ha az érték null vagy üres vagy nem egy üres karaktert(spacest) adtunk meg vagy nem lehet 50 karakternél több
                        if (value == null ||
                            value.isEmpty ||
                            //egész számá valo konvertálás , ha sikertelen akkor null értéket adja meg 
                            int.tryParse(value) == null ||
                            //egy érvényes egész szám, de nem pozitív (azaz nulla vagy negatív).
                            int.tryParse(value)! <= 0) {
                          return 'Must be a valid positive number.';
                        }
                        return null;
                      },
                      //kezdeti érték , stringként kell kezelni
                      initialValue: '1',
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: DropdownButtonFormField(items: [
                      for (final category in categories.entries)
                        DropdownMenuItem(
                          value: category.value,
                          child: Row(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                color: category.value.color,
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Text(category.value.title),
                            ],
                          ),
                        ),
                    ], onChanged: (value) {}),
                  )
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text('Reset'),
                  ),
                  ElevatedButton(
                      onPressed: _saveItem, child: const Text('Add item'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
