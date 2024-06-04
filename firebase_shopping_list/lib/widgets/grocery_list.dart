import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_list/constans/urls.dart';
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/new_item.dart';
import 'package:http/http.dart' as http;

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  List<GroceryItem> _groceryItems = [];
  var _isLoading = true;

  String? _error;

//képernyő betöltésénél a loadItems meghívása ami get kérést küld
  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  void _loadItems() async {
    final url = Uri.https(
      APIEndpoints.baseURL,
      APIEndpoints.shoppingList,
    );

    final response = await http.get(url);
    // A válasz body-ját (tartalmát) Stringként olvassa be
    final responseBody = response.body;

    // A JSON karakterláncot dekódolja és Map<String, dynamic> típusú objektummá alakítja
    // Ez a Map kulcs-érték párokat tartalmaz, ahol a kulcsok string-ek, az értékek pedig bármilyen típusúak lehetnek
    final Map<String, dynamic> listData = json.decode(responseBody);
    setState(() {
      if (response.statusCode >= 400) {
        _error = 'Failed to fetch data. Please try again later';
      }
    });
    // Üres lista a betöltött elemek tárolására
    final List<GroceryItem> _loadedItems = [];

    // Végigiterál a listData elemein (kulcs-érték párokon)
    for (final item in listData.entries) {
      // Az aktuális kategória keresése a kategóriák listájában
      // Első olyan kategória, amelynek címe megegyezik az aktuális listaelem "category" értékével
      // A keresés eredménye egy Category objektum lesz (feltételezve, hogy van ilyen osztály)
      final category = categories.entries
          .firstWhere(
              (catItem) => catItem.value.title == item.value['category'])
          .value;

      // Új GroceryItem objektum létrehozása a betöltött adatokból
      _loadedItems.add(
        GroceryItem(
          id: item.key, // Kulcs azonosítóként használva
          name: item.value['name'], // Értékből ("name") kiolvasva a név
          quantity: item
              .value['quantity'], // Értékből ("quantity") kiolvasva a mennyiség
          category: category, // Kategória objektum hozzáadása
        ),
      );
    }

    // Az állapot frissítése az új listaelemekkel
    setState(() {
      _groceryItems = _loadedItems;
    });
  }

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );
    if (newItem == null) {
      return;
    }
    setState(() {
      _groceryItems.add(newItem);
    });
  }

  void _removeItem(GroceryItem item) {
    setState(() {
      _groceryItems.remove(item);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text('No items addad yet.'),
    );

    if (_isLoading) {
      content = const Center(
        //loading widget animálva van
        child: CircularProgressIndicator(),
      );
    }

    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (ctx, index) => Dismissible(
          onDismissed: (direction) {
            _removeItem(_groceryItems[index]);
          },
          key: ValueKey(_groceryItems[index].id),
          child: ListTile(
            title: Text(
              _groceryItems[index].name,
            ),
            leading: Container(
              width: 24,
              height: 24,
              color: _groceryItems[index].category.color,
            ),
            trailing: Text(_groceryItems[index].quantity.toString()),
          ),
        ),
      );
    }

    if (_error != null) {
      content = Center(child: Text(_error!));
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Groceries'),
          actions: [
            IconButton(onPressed: _addItem, icon: const Icon(Icons.add))
          ],
        ),
        body: content);
  }
}
