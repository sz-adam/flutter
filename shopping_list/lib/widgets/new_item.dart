import 'package:flutter/material.dart';
import 'package:shopping_list/data/categories.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});

  @override
  _NewItemState createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
            child: Column(
          children: [
            //form specifikus widget Név
            TextFormField(
              maxLength: 50,
              decoration:const InputDecoration(
                label: Text('Name'),
              ),
              //lehetővé teszi egy fügvény hozzáadását
              validator: (value) {
                return 'demo...';
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
                  ], onChanged: (value){}),
                )
              ],
            )
          ],
        )),
      ),
    );
  }
}
