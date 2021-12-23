// import 'dart:convert';

import 'package:daily_cooking/models/foodinfo.dart';
import 'package:daily_cooking/services/food_DBHelper.dart';
import 'package:daily_cooking/shared/constant.dart';
import 'package:flutter/material.dart';

class FoodList extends StatefulWidget {
  @override
  _FoodListState createState() => _FoodListState();
}

// List<FoodInfo> counterstest = [
//   foodInfo(
//       foodName: "Test12",
//       startDate:
//           DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()).toString(),
//       foodType: "Breakfast"),
//   foodInfo(
//       foodName: "Test1",
//       startDate:
//           DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now()).toString(),
//       foodType: "Breakfast"),
// ];
String error = '';
String itemName = "";
String _newCurrentFoodType = "";
final List<String> foodType = ['All', 'Breakfast', 'Lunch', 'Dinner'];

class _FoodListState extends State<FoodList> {
  void _showSettingpanel(int id) {
    final _formkey = GlobalKey<FormState>();
    FoodDBHelper _foodDBHelper = FoodDBHelper();
    TextEditingController myController = TextEditingController();
    final List<String> foodTypeUpdate = ['Breakfast', 'Lunch', 'Dinner'];
    myController.text = itemName;
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        builder: (context) {
          return Container(
            height: 235,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/food.jpg"),
                fit: BoxFit.contain,
              ),
            ),
            //color: Colors.teal,
            //  padding: EdgeInsets.symmetric(vertical: 1.0, horizontal: 10.0),
            child: Container(
              child: Scaffold(
                backgroundColor: Colors.brown[100],
                body: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: myController,
                          decoration: textInputDecoration,
                          validator: (value) =>
                              value.isEmpty ? 'Enter the Item Name' : null,
                          onChanged: (value) {
                            setState(() {
                              itemName = value;
                            });
                          },
                        ),
                        SizedBox(height: 5.0),
                        DropdownButtonFormField(
                            decoration: textInputDecoration,
                            value: _newCurrentFoodType,
                            items: foodTypeUpdate.map((type) {
                              return DropdownMenuItem(
                                  child: Text('$type'), value: type);
                            }).toList(),
                            validator: (_newCurrentFoodType) =>
                                _newCurrentFoodType == null ||
                                        _newCurrentFoodType == ""
                                    ? 'Select the Food Type'
                                    : null,
                            onChanged: (val) {
                              setState(() {
                                _newCurrentFoodType = val;

                                // loadRecipesByFoodType(_currentFoodType);
                              });
                            }),
                        SizedBox(height: 5.0),
                        // ignore: deprecated_member_use
                        RaisedButton(
                          onPressed: () async {
                            if (_formkey.currentState.validate()) {
                              //myController.clear();
                              //setState(() => loading = true);
                              dynamic result =
                                  await _foodDBHelper.updateFoodItem(
                                      id, itemName, _newCurrentFoodType);
                              if (result == null) {
                                setState(() {
                                  error = 'Please supply valid Item Name';
                                });
                              }
                              Navigator.pop(context);
                              _foodDBHelper.initializeDatabase().then((value) {
                                print('------database intialized');
                                loadRecipesByFoodType(_newCurrentFoodType);
                              });

                              // Navigator.of(context)
                              //     .popAndPushNamed("/foodList")
                              //     .then((value) => setState(() {}));
                              //widget.foodListState.

                            }
                          },
                          color: Colors.pink,
                          child: Text('Update',
                              style: TextStyle(color: Colors.white)),
                        ),
                        Text(error,
                            style:
                                TextStyle(color: Colors.red, fontSize: 14.0)),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  List<FoodInfo> counterstest = [];
  var _recipes;
  String _currentFoodType;
  FoodDBHelper _foodDBHelper = FoodDBHelper();
  @override
  void initState() {
    _foodDBHelper.initializeDatabase().then((value) {
      print('------database intialized');
      loadRecipesByFoodType("All");
    });
    super.initState();
  }

  void loadRecipesByFoodType(String foodType) async {
    counterstest.clear();
    _recipes = await _foodDBHelper.getRecipesbyFoodType(foodType);
    print('query all rows:');
    _recipes.forEach(print);
    _recipes.forEach((element) {
      counterstest.add(element);
      if (mounted) setState(() {});
    });
  }

  void deleteItemById(int id) async {
    int rowDeleted = await _foodDBHelper.delete(id);
    print(rowDeleted);
  }

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
            child: Stack(children: [
              Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.list_alt,
                        size: 40.0,
                      ),
                      SizedBox(
                        width: 1.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Container(
                          color: Colors.purple[100],
                          width: 250.0,
                          height: 60.0,
                          child: DropdownButtonFormField(
                              decoration: textInputDecoration,
                              value: _currentFoodType,
                              items: foodType.map((type) {
                                if (_currentFoodType == null ||
                                    _currentFoodType == "") {
                                  _currentFoodType = "All";
                                }
                                return DropdownMenuItem(
                                    child: Text('$type'), value: type);
                              }).toList(),
                              onChanged: (val) {
                                setState(() {
                                  _currentFoodType = val;
                                  loadRecipesByFoodType(_currentFoodType);
                                });
                              }),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      width: 400.0,
                      height: 40.0,
                      // padding:
                      //     EdgeInsets.only(right: 190.0, left: 190.0, top: 1.0),
                      color: Colors.red[600],
                      child: Center(
                        child: Text(
                          '$_currentFoodType' + ' Items',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 110.0),
                child: Container(
                  child: ListView.builder(
                    itemCount: counterstest.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 100,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: Colors.amber,
                          elevation: 10,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListTile(
                                // ignore: deprecated_member_use
                                leading: FlatButton(
                                    onPressed: () {
                                      //counterstest.removeAt(index);
                                      itemName = counterstest[index].foodName;
                                      _newCurrentFoodType =
                                          counterstest[index].foodType;
                                      _showSettingpanel(counterstest[index].id);
                                    },
                                    child: Icon(Icons.edit_sharp, size: 25)),
                                title: Center(
                                  child: Text(
                                    counterstest[index].foodName,
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: Colors.pink[900],
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                trailing: Wrap(
                                  spacing: 12,
                                  children: [
                                    // ignore: deprecated_member_use
                                    FlatButton(
                                        onPressed: () async {
                                          dynamic result = await _foodDBHelper
                                              .delete(counterstest[index].id);
                                          if (result == 1) {
                                            setState(() {
                                              counterstest.remove(index);
                                              _foodDBHelper
                                                  .initializeDatabase()
                                                  .then((value) {
                                                print(
                                                    '------database intialized');
                                                loadRecipesByFoodType(
                                                    _currentFoodType);
                                              });
                                            });
                                          }
                                        },
                                        child: Icon(Icons.delete, size: 25)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ]),
          )),
    );
  }
}
