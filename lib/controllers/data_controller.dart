import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:macro_calculator/utils/enums.dart';

class DataController extends ChangeNotifier {
  Gender? gender;
  double? height;

  DistanceUnit? unit;
  RaceType? raceType; //类型
  double? distance; //距离
  double? finishTime; //完成时间
  int? age;

  ActivityLevel? activityLevel;
  Goal? goal;

  Box box = Hive.box('data');

  DataController() {
    this.gender = Gender.values[box.get('gender') ?? 0];
    this.height = box.get('height') ?? 170;
    this.finishTime = box.get('finishTime') ?? 105;
    this.distance = box.get('distance') ?? 70;
    this.age = box.get('age') ?? 25;
    this.activityLevel = ActivityLevel.values[box.get('activityLevel') ?? 2];
    this.unit = DistanceUnit.values[box.get('unit') ?? 1];
    this.raceType = RaceType.values[box.get('raceType') ?? 0];
    this.goal = Goal.values[box.get('goal') ?? 0];
  }

  void setGender(Gender? gender) async {
    this.gender = gender;
    box.put('gender', gender?.index);
    notifyListeners();
  }

  void setHeight(double? height) {
    this.height = height;
    box.put('height', height);
    notifyListeners();
  }

  void setDistance(double? distance) {
    this.distance = distance;
    box.put('distance', distance);
    //If changed, it means start a customized type
    this.raceType = RaceType.tCustomized;
    box.put('raceType', RaceType.tCustomized.index);
    notifyListeners();
  }

  void setAge(int? age) {
    this.age = age;
    box.put('age', age);
    notifyListeners();
  }

  void setActivityLevel(ActivityLevel? activityLevel) {
    this.activityLevel = activityLevel;
    box.put('activityLevel', activityLevel?.index);
    notifyListeners();
  }

  void setUnit(DistanceUnit? unit) {
    this.unit = unit;
    box.put('unit', unit?.index);
    notifyListeners();
  }

  void setRaceType(RaceType? raceType) {
    this.raceType = raceType;
    box.put('raceType', raceType?.index);
    if (raceType != RaceType.tCustomized) {
      this.distance = raceType?.distance;
      box.put('distance', this.distance);
    }
    notifyListeners();
  }

  void setGoal(Goal? goal) {
    this.goal = goal;
    box.put('goal', goal?.index);

    notifyListeners();
  }

  List<RaceType> getRaceType() {
    return unit == DistanceUnit.metric
        ? RaceType.metricTypes
        : RaceType.statuteTypes;
  }

  List<String> distanceFormat() {
    if (unit == DistanceUnit.metric) {
      if (distance! <= 1000) {
        return ["${distance!.toStringAsFixed(0)}", "${unit!.unit1}"];
      } else {
        if (distance == 21097.5) {
          return ["21.0975", "${unit!.unit2}"];
        }
        if (distance == 42195) {
          return ["42.195", "km"];
        }
      }
    }
    return ["${(distance! / 1000).toStringAsFixed(1)}", "${unit!.unit2}"];
  }
}
