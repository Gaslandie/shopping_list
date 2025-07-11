import 'package:flutter/material.dart';
import 'package:shopping_app/models/grocery_item.dart';
import 'package:shopping_app/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groceryItems = [];

  void _addItem() async {
    final newItem = await Navigator.of(
      context,
    ).push<GroceryItem>(MaterialPageRoute(builder: (ctx) => NewItem()));

    if (newItem == null) {
      return;
    }

    //setState pour rebuild et utiliser notre _groceryItems
    setState(() {
      _groceryItems.add(newItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [IconButton(onPressed: _addItem, icon: const Icon(Icons.add))],
      ),
      body: _groceryItems.isEmpty
          ? Center(
              child: Text(
                'nothing here, please add',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: _groceryItems.length,
              itemBuilder: (ctx, index) => Dismissible(
                key: ValueKey(_groceryItems[index].id),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) {
                  final removedItem = _groceryItems[index];
                  final removedIndex = index;
                  setState(() {
                    _groceryItems.removeAt(index);
                  });

                  //Affiche un SnackBar avec la possibilité d'annuler
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${removedItem.name} supprimé'),
                      action: SnackBarAction(
                        label: 'Annuler',
                        onPressed: () {
                          setState(() {
                            _groceryItems.insert(removedIndex, removedItem);
                          });
                        },
                      ),
                      duration: Duration(seconds: 3),
                    ),
                  );
                },
                child: ListTile(
                  title: Text(_groceryItems[index].name),
                  //leading, le contenu avant le title
                  leading: Container(
                    width: 24,
                    height: 24,
                    color: _groceryItems[index].category.color,
                  ),
                  //trailing , le contenu après le title
                  trailing: Text(_groceryItems[index].quantity.toString()),
                ),
              ),
            ),
    );
  }
}
