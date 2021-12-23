import 'file:///D:/Projects/Andriod/apps/daily_cooking/lib/screens/home/groceries.dart';
import 'package:daily_cooking/screens/home/foodlist.dart';
import 'package:daily_cooking/screens/home/weeklyfood.dart';
import 'package:daily_cooking/shared/constant.dart';
import 'package:daily_cooking/shared/dialog.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        // elevation: 0.0,
        // actions: [
        //   FlatButton.icon(
        //     onPressed: () {
        //       //_showSettingpanel();
        //     },
        //     icon: Icon(Icons.person),
        //     label: Text("Login/Register"),
        //   ),
        // ],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage('images/food.jpg'),
          fit: BoxFit.fill,
        )),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: boxBorder,
                    width: 180.0,
                    height: 150.0,
                    child: Card(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FoodList()),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'images/image3.jpg',
                                    width: 100.0,
                                    height: 80.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'My Items',
                                      style: TextStyle(
                                          color: Colors.teal[900],
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: boxBorder,
                      width: 180.0,
                      height: 150.0,
                      child: Card(
                        child: InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDialogBox(
                                    title: "Add Items to List",
                                    text: "Add",
                                    foodType: ['Breakfast', 'Lunch', 'Dinner'],
                                  );
                                });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'images/add_list.jpg',
                                      width: 100.0,
                                      height: 80.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Add Items',
                                        style: TextStyle(
                                            color: Colors.teal[900],
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: boxBorder,
                    width: 180.0,
                    height: 150.0,
                    child: Card(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GroceriesPage()),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'images/groceries.jpg',
                                    width: 100.0,
                                    height: 80.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Groceries',
                                      style: TextStyle(
                                          color: Colors.teal[900],
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: boxBorder,
                      width: 180.0,
                      height: 150.0,
                      child: Card(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WeeklyFood()),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'images/weekly.jpg',
                                      width: 100.0,
                                      height: 80.0,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Weekly Food Planner',
                                        style: TextStyle(
                                            color: Colors.teal[900],
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.add_circle,
          //     size: 50.0,
          //   ),
          //   label: '',
          //   backgroundColor: Colors.blue[800],
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.horizontal_split_rounded),
            label: 'More',
          ),
        ],
      ),
    );
  }
}
