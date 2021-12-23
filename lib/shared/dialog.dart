import 'dart:ui';
import 'package:daily_cooking/models/foodinfo.dart';
import 'package:daily_cooking/services/food_DBHelper.dart';

import 'constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomDialogBox extends StatefulWidget {
  final String title, text;
  final Image img;
  final List<String> foodType;
  String itemName;
  CustomDialogBox({Key key, this.title, this.text, this.img, this.foodType})
      : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  String _currentFoodType;
  FoodDBHelper _foodDBHelper = FoodDBHelper();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 260.0,
          alignment: Alignment.topCenter,
          padding: EdgeInsets.only(
              left: Constants.padding,
              top: Constants.avatarRadius + Constants.padding,
              right: Constants.padding,
              bottom: Constants.padding),
          margin: EdgeInsets.only(top: Constants.avatarRadius),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            // borderRadius: BorderRadius.circular(Constants.padding),
            // boxShadow: [
            //   BoxShadow(
            //       color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
            // ]
          ),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  decoration: textInputDecoration,
                  validator: (value) =>
                      value.isEmpty ? 'Enter the Item Name' : null,
                  onChanged: (value) {
                    setState(() {
                      widget.itemName = value;
                    });
                  },
                ),
                SizedBox(height: 10.0),
                DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentFoodType,
                    items: widget.foodType.map((type) {
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
                      });
                    }),
                Expanded(
                  child: Row(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 5.0),
                          // ignore: deprecated_member_use
                          RaisedButton(
                              onPressed: () {
                                if (_formkey.currentState.validate()) {
                                  onSaveRecipe(
                                      widget.itemName, _currentFoodType);
                                  Navigator.of(context).pop();
                                }
                              },
                              color: Colors.amber,
                              child: Text(
                                widget.text,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              )),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 120.0),
                        child: Align(
                          alignment: AlignmentDirectional.centerEnd,
                          // ignore: deprecated_member_use
                          child: RaisedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              color: Colors.pink,
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // Positioned(
        //   left: Constants.padding,
        //   right: Constants.padding,
        //   child: CircleAvatar(
        //     backgroundColor: Colors.transparent,
        //     radius: Constants.avatarRadius,
        //     child: ClipRRect(
        //         borderRadius:
        //             BorderRadius.all(Radius.circular(Constants.avatarRadius)),
        //         child: Image.asset("images/kitchenroom.jpg")),
        //   ),
        // ),
      ],
    );
  }

  void onSaveRecipe(String foodName, String _currentFoodType) {
    DateTime scheduleAlarmDateTime = DateTime.now();
    if (foodName != null &&
        foodName != "" &&
        _currentFoodType != null &&
        _currentFoodType != "") {
      var foodInfo = FoodInfo(
        foodName: foodName,
        foodType: _currentFoodType,
        timeStamp: scheduleAlarmDateTime,
      );
      _foodDBHelper.insertRecipes(foodInfo);
    }
  }
}
