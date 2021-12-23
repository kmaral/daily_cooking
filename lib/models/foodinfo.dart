class FoodInfo {
  FoodInfo({
    this.id,
    this.foodName,
    this.foodType,
    this.timeStamp,
  });

  int id;
  String foodName;
  String foodType;
  DateTime timeStamp;

  factory FoodInfo.fromMap(Map<String, dynamic> json) => FoodInfo(
        id: json["id"],
        foodName: json["foodName"],
        foodType: json["foodType"],
        timeStamp: DateTime.parse(json["timeStamp"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "foodName": foodName,
        "foodType": foodType,
        "timeStamp": timeStamp.toIso8601String(),
      };
}

class WeeklyFoodInfo {
  WeeklyFoodInfo(
      {this.foodName1,
      this.foodName2,
      this.foodName3,
      //this.datewithWeekly,
      this.weekName});

  String foodName1;
  String foodName2;
  String foodName3;
  // DateTime datewithWeekly;
  String weekName;

  factory WeeklyFoodInfo.fromMap(Map<String, dynamic> json) => WeeklyFoodInfo(
        foodName1: json["foodName1"],
        foodName2: json["foodName2"],
        foodName3: json["foodName3"],
        //datewithWeekly: DateTime.parse(json["datewithWeekly"]),
        weekName: json["weekName"],
      );

  Map<String, dynamic> toMap() => {
        "foodName1": foodName1,
        "foodName2": foodName2,
        "foodName3": foodName3,
        // "datewithWeekly": datewithWeekly.toIso8601String(),
        "weekName": weekName,
      };
}
