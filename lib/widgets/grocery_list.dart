import 'package:flutter/material.dart';
import 'package:shopping_app/data/dummy_item.dart';

class GroceryList extends StatelessWidget {
  const GroceryList({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
      ),
      body: ListView.builder(
        itemCount: groceryItems.length,
        itemBuilder: (ctx, index) => ListTile(
        title: Text(groceryItems[index].name),
        //leading, le contenu avant le title
        leading: Container(
          width: 24,
          height: 24,
          color: groceryItems[index].category.color,
        ),
        //trailing , le contenu après le title
        trailing: Text(groceryItems[index].quantity.toString()),
      )),
    );
  }
}
