import 'package:daily_cooking/models/foodinfo.dart';
import 'package:daily_cooking/services/food_DBHelper.dart';
import 'package:daily_cooking/shared/constant.dart';
import 'package:flutter/material.dart';

class UpdateFoodInfo extends StatefulWidget {
  final int id;

  UpdateFoodInfo(this.id);
  //UpdateFoodInfo(this.id, {this.setStateOfFirstScreen});

  @override
  _UpdateFoodInfoState createState() => _UpdateFoodInfoState();
}

class _UpdateFoodInfoState extends State<UpdateFoodInfo> {
  final _formkey = GlobalKey<FormState>();

  final List<String> foodType = ['Breakfast', 'Lunch', 'Dinner'];

  var _recipes;
  String error = '';
  String itemName;
  String _currentFoodType;
  FoodDBHelper _foodDBHelper = FoodDBHelper();
  TextEditingController myController = TextEditingController();
  List<FoodInfo> counterstest = [];

  @override
  void initState() {
    _foodDBHelper.initializeDatabase().then((value) {
      print('------database intialized');
      loadRecipesById(widget.id);
    });
    super.initState();
  }

  void loadRecipesById(int id) async {
    _recipes = await _foodDBHelper.getFoodItemsById(id);
    counterstest.clear();
    print('query all rows:');
    _recipes.forEach(print);
    _recipes.forEach((element) {
      counterstest.add(element);
      if (mounted) setState(() {});
    });
    print(counterstest[0].foodName);
    itemName = counterstest[0].foodName;
    _currentFoodType = counterstest[0].foodType;
  }

  @override
  Widget build(BuildContext context) {
    myController.text = itemName;
    return Container(
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(
                  // initialValue: counterstest != null && counterstest.length > 0
                  //     ? counterstest[0].foodName
                  //     : itemName,
                  controller: myController,
                  decoration: textInputDecoration,
                  validator: (value) =>
                      value.isEmpty ? 'Enter the Item Name' : null,
                  onChanged: (value) {
                    setState(() {
                      itemName = value;
                      // myController.text = value;
                    });
                  },
                ),
                SizedBox(height: 5.0),
                DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentFoodType,
                    items: foodType.map((type) {
                      return DropdownMenuItem(
                          child: Text('$type'), value: type);
                    }).toList(),
                    validator: (_currentFoodType) =>
                        _currentFoodType == null || _currentFoodType == ""
                            ? 'Select the Food Type'
                            : null,
                    onChanged: (val) {
                      setState(() {
                        _currentFoodType = val;

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
                      dynamic result = await _foodDBHelper.updateFoodItem(
                          widget.id, itemName, _currentFoodType);
                      if (result == null) {
                        setState(() {
                          error = 'Please supply valid Item Name';
                        });
                      }
                      if (result == 1) {
                        Navigator.pop(context);
                        setState(() {});
                      }
                    }
                  },
                  color: Colors.pink,
                  child: Text('Update', style: TextStyle(color: Colors.white)),
                ),
                Text(error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
