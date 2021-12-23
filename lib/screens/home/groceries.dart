import 'package:daily_cooking/shared/constant.dart';
import 'package:flutter/material.dart';

class GroceriesPage extends StatefulWidget {
  @override
  _GroceriesPageState createState() => _GroceriesPageState();
}

String error = '';
String itemName;
final List<String> foodType = ['All', 'Breakfast', 'Lunch', 'Dinner'];

class _GroceriesPageState extends State<GroceriesPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
          backgroundColor: Colors.teal,
          appBar: AppBar(
            title: Row(
              children: [
                kitchenLogo,
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  'My Kitchen',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('images/food.jpg'),
              fit: BoxFit.fill,
            )),
            //color: Colors.brown,
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      width: 400.0,
                      height: 100.0,
                      // padding:
                      //     EdgeInsets.only(right: 190.0, left: 190.0, top: 1.0),
                      color: Colors.red[600],
                      child: Center(
                        child: Text(
                          'Coming Soon',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
