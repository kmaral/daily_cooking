import 'package:daily_cooking/screens/home/foodlist.dart';
import 'package:daily_cooking/screens/home/home.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Kitchen',
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/foodList': (context) => FoodList(),
      },
    ),
  );
}


  // void loadRecipesById(int id) async {
  //   _recipes = await _foodDBHelper.getFoodItemsById(id);
  //   counterstest.clear();
  //   print('query all rows:');
  //   _recipes.forEach(print);
  //   _recipes.forEach((element) {
  //     counterstest.add(element);
  //     if (mounted) setState(() {});
  //   });
  //   print(counterstest[0].foodName);
  // }
