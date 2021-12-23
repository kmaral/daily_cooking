import 'dart:math';
import 'package:daily_cooking/models/foodinfo.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

final String tableFood = 'recipesList';
final String columnId = 'id';
final String columnfoodName = 'foodName';
final String columnfoodType = 'foodType';
final String columnDateTime = 'timeStamp';

class FoodDBHelper {
  static Database _database;
  static FoodDBHelper _foodDBHelper;

  FoodDBHelper._createInstance();
  factory FoodDBHelper() {
    if (_foodDBHelper == null) {
      _foodDBHelper = FoodDBHelper._createInstance();
    }
    return _foodDBHelper;
  }

//   Future open(String path) async {
//     _database = await openDatabase(path, version: 1,
//         onCreate: (Database db, int version) async {
//       await db.execute('''create table $tableFood (
//           $columnId integer primary key autoincrement,
//           $columnfoodName text not null,
//           $columnfoodType text not null,
//           $columnDateTime text not null);
// ''');
//     });
//   }
  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    var dir = await getDatabasesPath();
    var path = dir + "food.db";

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          create table $tableFood ( 
         $columnId integer primary key autoincrement, 
          $columnfoodName text not null,
          $columnfoodType text not null,
          $columnDateTime text not null)
        ''');
      },
    );
    return database;
  }

  void insertRecipes(FoodInfo foodInfo) async {
    var db = await this.database;
    int result = await db.insert(tableFood, foodInfo.toMap());
    print('result : $result');
  }

  Future<List<FoodInfo>> getRecipesbyFoodType(String foodType) async {
    List<FoodInfo> _recipes = [];
    var result;
    var db = await this.database;
    if (foodType != "All") {
      result = await db.query(tableFood,
          where: '$columnfoodType = ?', whereArgs: [foodType]);
    } else {
      result = await db.query(tableFood);
      // result = await db.rawQuery(
      //     "SELECT * FROM $tableFood ORDER BY RANDOM() LIMIT 8", null);
    }
    if (result != null) {
      result.forEach((element) {
        var foodInfo = FoodInfo.fromMap(element);
        _recipes.add(foodInfo);
      });
    }
    return _recipes;
  }

  Future<List<WeeklyFoodInfo>> getRecipesbyWeekly() async {
    List<WeeklyFoodInfo> _recipes = [];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("getSavedRecipes")) {
      prefs.remove("getSavedRecipes");
    }
    if (prefs.containsKey("getSavedRecipes")) {
      //_recipes = json.decode(prefs.get("getSavedRecipes"));
    }
    if (_recipes.isEmpty) {
      List<FoodInfo> _foodRecipes = [];
      for (int i = 0; i < 7; i++) {
        WeeklyFoodInfo weeklyFoodInfo = WeeklyFoodInfo();

        _foodRecipes = await getRecipesbyFoodType("Breakfast");
        if (_foodRecipes.isEmpty == false) {
          if (i != _foodRecipes.length - 1) {
            weeklyFoodInfo.foodName1 =
                _foodRecipes[randomNumber(0, _foodRecipes.length)].foodName;
          } else {
            weeklyFoodInfo.foodName1 = _foodRecipes[i].foodName;
          }
          _foodRecipes.clear();
        } else {
          weeklyFoodInfo.foodName1 = "";
        }
        _foodRecipes = await getRecipesbyFoodType("Lunch");
        if (_foodRecipes.isEmpty == false) {
          if (i != _foodRecipes.length - 1) {
            weeklyFoodInfo.foodName2 =
                _foodRecipes[randomNumber(0, _foodRecipes.length)].foodName;
          } else {
            weeklyFoodInfo.foodName2 = _foodRecipes[i].foodName;
          }
          _foodRecipes.clear();
        } else {
          weeklyFoodInfo.foodName2 = "";
        }
        _foodRecipes = await getRecipesbyFoodType("Dinner");
        if (_foodRecipes.isEmpty == false) {
          if (i != _foodRecipes.length - 1) {
            weeklyFoodInfo.foodName3 =
                _foodRecipes[randomNumber(0, _foodRecipes.length)].foodName;
          } else {
            weeklyFoodInfo.foodName3 = _foodRecipes[i].foodName;
          }
          _foodRecipes.clear();
        } else {
          weeklyFoodInfo.foodName3 = "";
        }

        weeklyFoodInfo.weekName =
            DateFormat('EEEE').format(DateTime.now().add(Duration(days: i)));

        _recipes.add(weeklyFoodInfo);
      }
    }
    // if (_recipes.length > 0) {
    //   prefs.setString("getSavedRecipes", json.encode(_recipes));
    // }
    if (prefs.containsKey("getSavedRecipes")) {
      prefs.remove("getSavedRecipes");
    }

    //prefs.setString("getSavedRecipes", json.encode(_recipes));
    return _recipes;
  }

  int randomNumber(min, max) {
    if (max == 0) {
      return 0;
    }
    var rn = new Random.secure();
    return min + rn.nextInt(max - min);
  }

  Future<int> delete(int id) async {
    var db = await this.database;
    return await db.delete(tableFood, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> updateFoodItem(int id, String itemName, String foodType) async {
    var db = await this.database;
    //return await db.delete(tableFood, where: '$columnId = ?', whereArgs: [id]);
    int updateCount = await db.rawUpdate('''
    UPDATE $tableFood 
    SET $columnfoodName = ?, $columnfoodType = ? 
    WHERE $columnId = ?
    ''', [itemName, foodType, id]);

    return updateCount;
  }

  Future<List<FoodInfo>> getFoodItemsById(int id) async {
    List<FoodInfo> _recipes = [];
    final db = await database;
    var result =
        await db.query(tableFood, where: '$columnId = ?', whereArgs: [id]);
    if (result != null) {
      result.forEach((element) {
        var foodInfo = FoodInfo.fromMap(element);
        _recipes.add(foodInfo);
      });
    }
    return _recipes;
  }
}
