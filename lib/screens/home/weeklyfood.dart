import 'package:daily_cooking/models/foodinfo.dart';
import 'package:daily_cooking/services/food_DBHelper.dart';
import 'package:daily_cooking/shared/constant.dart';
import 'package:flutter/material.dart';

class WeeklyFood extends StatefulWidget {
  @override
  _WeeklyFoodState createState() => _WeeklyFoodState();
}

// List<WeeklyFoodInfo> counterstest = [
//   WeeklyFoodInfo(
//       foodName1: "Test1",
//       foodName2: "Test2",
//       foodName3: "Test3",
//       weekName: "Saturday"),
// ];
//List<WeeklyFoodInfo> counterstest = [];

class _WeeklyFoodState extends State<WeeklyFood> {
  List<WeeklyFoodInfo> counterstest = [];

  var _recipes;

  FoodDBHelper _foodDBHelper = FoodDBHelper();
  @override
  void initState() {
    _foodDBHelper.initializeDatabase().then((value) {
      print('------database intialized');
      getRecipesbyWeekly();
    });
    super.initState();
  }

  void getRecipesbyWeekly() async {
    counterstest.clear();
    _recipes = await _foodDBHelper.getRecipesbyWeekly();

    _recipes.forEach(print);
    _recipes.forEach((element) {
      counterstest.add(element);
      if (mounted) setState(() {});
    });
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
            actions: [
              // ignore: deprecated_member_use
              FlatButton.icon(
                  onPressed: () {
                    _foodDBHelper.initializeDatabase().then((value) {
                      print('------database intialized');
                      getRecipesbyWeekly();
                    });
                  },
                  icon: Icon(Icons.refresh_sharp, size: 30.0),
                  label: Text(""))
            ],
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
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Container(
                        width: 400.0,
                        height: 40.0,
                        // padding:
                        //     EdgeInsets.only(right: 190.0, left: 190.0, top: 1.0),
                        color: Colors.red[600],
                        child: Center(
                          child: Text(
                            'Weekly Food Planner',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 50.0),
                child: Container(
                  child: ListView.builder(
                    itemCount: counterstest.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 200,
                        height: 110,
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
                                leading: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        "Breakfast: " +
                                            counterstest[index].foodName1,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          // color: Colors.pink[900],
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      "Lunch: " + counterstest[index].foodName2,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        // color: Colors.pink[900],
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3.0,
                                    ),
                                  ],
                                ),
                                title: Text(
                                  "Dinner: " + counterstest[index].foodName3,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    // color: Colors.pink[900],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                // ignore: deprecated_member_use
                                trailing: FlatButton(
                                    onPressed: () {},
                                    child: Text(
                                      counterstest[index].weekName,
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w600),
                                    )),
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
