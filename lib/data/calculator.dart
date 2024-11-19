import 'package:flutter/material.dart';
import 'package:pacelator_toolbox/pages/results_page.dart';
import 'package:pacelator_toolbox/utils/enums.dart';
import 'package:pacelator_toolbox/utils/number_format.dart';

class Calculator {
  final double distance;
  final TabMode tabMode;
  final TimeOfDay pace;
  final TimeOfDay etf;
  final RaceType raceType;
  final DistanceUnit unit;

  Calculator({
    required this.distance,
    required this.tabMode,
    required this.pace,
    required this.etf,
    required this.raceType,
    required this.unit,
  });

  String estimatedTimeFinished(bool needLeadingZero) {
    Map<String, int> etfMap = getEtfTimeMap();
    if (needLeadingZero) {
      return "${formatNumLeftPadding0(etfMap['hour']!)}:${formatNumLeftPadding0(etfMap['minute']!)}:${formatNumLeftPadding0(etfMap['second']!)}";
    } else {
      return "${etfMap['hour'] == 0 ? '' : '${formatNumLeftPadding0(etfMap['hour']!)}:'}${formatNumLeftPadding0(etfMap['minute']!)}:${formatNumLeftPadding0(etfMap['second']!)}";
    }
  }

  Map<String, int> getEtfTimeMap() {
    if (tabMode == TabMode.estimatedFinishTime) {
      return {
        "hour": etf.hour,
        "minute": etf.minute,
        "second": 0,
      };
    } else {
      //pace * distance
      //Here hour is minute actually
      int secondsPerKm = pace.hour * 60 + pace.minute;
      int totalTimeInSecond = (distance / 1000 * secondsPerKm).toInt();
      int hours = totalTimeInSecond ~/ 3600;
      int minutes = (totalTimeInSecond % 3600) ~/ 60;
      int seconds = totalTimeInSecond % 3600 % 60;
      return {
        "hour": hours,
        "minute": minutes,
        "second": seconds,
      };
    }
  }

  Map<String, int> getPace() {
    if (tabMode == TabMode.estimatedFinishTime) {
      //etf/distance
      int etfInSecond = etf.hour * 3600 + etf.minute * 60;
      int speedInSecond =
          etfInSecond ~/ (distance / getDividerForDistanceUnit(unit));
      int hours = (speedInSecond ~/ 3600);
      int minutes = (speedInSecond % 3600) ~/ 60;
      int seconds = speedInSecond % 3600 % 60;
      return {
        "hour": hours,
        "minute": minutes,
        "second": seconds,
      };
    } else {
      //Here hour is minute actually
      return {
        "hour": 0,
        "minute": pace.hour,
        "second": pace.minute,
      };
    }
  }

  String averagePace() {
    Map<String, int> paceMap = getPace();
    return "${paceMap['hour'] == 0 ? '' : '${formatNumLeftPadding0(paceMap['hour']!)}:'}${formatNumLeftPadding0(paceMap['minute']!)}:${formatNumLeftPadding0(paceMap['second']!)}";
  }

  String getLastSplitTime(int beforeSplitNum) {
    Map<String, int> paceMap = getPace();
    int paceInSecond =
        paceMap['hour']! * 3600 + paceMap['minute']! * 60 + paceMap['second']!;
    int splitsBeforeSecond = paceInSecond * beforeSplitNum;
    Map<String, int> etfMap = getEtfTimeMap();
    int timeTotalInSecond =
        etfMap['hour']! * 3600 + etfMap['minute']! * 60 + etfMap['second']!;
    int lastSplitInSecond = timeTotalInSecond - splitsBeforeSecond;
    int hours = (lastSplitInSecond ~/ 3600);
    int minutes = (lastSplitInSecond % 3600) ~/ 60;
    int seconds = lastSplitInSecond % 3600 % 60;
    return "${hours == 0 ? '' : '${formatNumLeftPadding0(hours)}:'}${formatNumLeftPadding0(minutes)}:${formatNumLeftPadding0(seconds)}";
  }

  List<RunSplit> splits() {
    double divider = getDividerForDistanceUnit(unit);
    int splitNum = distance ~/ divider;
    final double left =
        (distance - divider * splitNum) / divider; //one split not enough
    if (left != 0) {
      splitNum++;
    }

    String avgPace = averagePace();

    List<RunSplit> splits = [];
    Map<String, int> paceMap = getPace();
    int paceInSecond =
        paceMap['hour']! * 3600 + paceMap['minute']! * 60 + paceMap['second']!;
    for (var i = 0; i < splitNum; i++) {
      String cumulativeTime = getCumulativeTime(i, paceInSecond);
      RunSplit runSplit = RunSplit(
          splitNo: '${i + 1}',
          splitDistance:
              '${left != 0 && i == splitNum - 1 ? left.toStringAsFixed(1) : 1.0}',
          splitPace: avgPace,
          splitTime: i == splitNum - 1
              ? estimatedTimeFinished(false)
              : cumulativeTime);
      splits.add(runSplit);
    }
    return splits;
  }

  String getCumulativeTime(int splitNo, int paceInSecond) {
    int cumulativeSecond = paceInSecond * (splitNo + 1);
    int hours = (cumulativeSecond ~/ 3600);
    int minutes = (cumulativeSecond % 3600) ~/ 60;
    int seconds = cumulativeSecond % 3600 % 60;
    return "${hours == 0 ? '' : '${formatNumLeftPadding0(hours)}:'}${formatNumLeftPadding0(minutes)}:${formatNumLeftPadding0(seconds)}";
  }
}
