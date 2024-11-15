import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;

//reference: https://github.com/flutter/website/blob/archived-master/examples/internationalization/minimal/lib/main.dart
//fk flutter l10n;so complex
class MinimalLocalizations {
  MinimalLocalizations(this.locale);

  final Locale locale;

  static MinimalLocalizations of(BuildContext context) {
    return Localizations.of<MinimalLocalizations>(
        context, MinimalLocalizations)!;
  }

  static const _localizedValues = <String, Map<String, String>>{
    'en': {
      'title': 'Pacelator Toolbox',
      'Light Mode': 'Light Mode',
      'Results': 'Results',
      'hhMMSS': 'HH:MM:SS',
      'lapNo': 'Lap No.',
      'newrathon': 'Pacelator',
      'lapDistance': 'Lap Distance',
      'lapTime': 'Cumulative Time',
      'splits': 'Laps',
      'Hour Label': 'Hours',
      'Minute Label': 'Minutes',
      'Calculate': 'Calculate',
      'Estimated Finish Time': 'Est. Finish Time',
      'Dark Mode': 'Dark Mode',
      'unit': 'Unit',
      'Pace': 'Pace',
      'Race Type': 'Race Type',
      'distance': 'Distance',
      'minPerKm': 'min/km',
      'minPerMi': 'min/mi',
      'raceType:customized': 'Customized Distance',
      'raceType:50m': '50m',
      'raceType:100m': '100m',
      'raceType:800m': '800m',
      'raceType:1000m': '1000m',
      'raceType:5k': '5km',
      'raceType:10k': '10km',
      'raceType:21k': 'Half Marathon',
      'raceType:30k': '30km',
      'raceType:42k': 'Marathon',
      'raceType:50k': '50km',
      'raceType:100k': '100km',
      'raceType:1mi': '1mi',
      'raceType:13mi': 'Half Marathon',
      'raceType:26mi': 'Marathon',
      'distanceUnit:metric': 'Metric',
      'distanceUnit:statute': 'Statute',
      'distanceUnit:unknown': 'Unknown',
      "Seconds Label": "Seconds",
      'shareMessage': 'Pacelator by Newrathon. Download It Now!',
    },
    'zh': {
      'title': 'Pacelator 工具箱',
      'unit': '单位',
      'splits': '计圈',
      'lapNo': '圈数',
      'lapDistance': '距离',
      'lapTime': '累计时间',
      'Results': '计算结果',
      'Calculate': '计算',
      'Hour Label': '小时',
      'hhMMSS': '时:分:秒',
      'Minute Label': '分钟',
      'minPerKm': '分钟/公里',
      'minPerMi': '分钟/英里',
      'Race Type': '比赛类型',
      'Light Mode': '浅色模式',
      'Dark Mode': '深色模式',
      'distance': '距离',
      'newrathon': 'Pacelator',
      'Estimated Finish Time': '预计完赛时间',
      'raceType:customized': '自定义距离',
      'raceType:50m': '50 米',
      'raceType:100m': '100 米',
      'raceType:800m': '800 米',
      'raceType:1000m': '1000 米',
      'raceType:5k': '5 千米',
      'raceType:10k': '10 千米',
      'raceType:21k': '半程马拉松',
      'raceType:30k': '30 千米',
      'raceType:42k': '马拉松',
      'raceType:50k': '50 千米',
      'raceType:100k': '100 千米',
      'raceType:1mi': '1 英里',
      'raceType:13mi': '半程马拉松',
      'raceType:26mi': '马拉松',
      'distanceUnit:metric': '公制',
      'distanceUnit:statute': '英制',
      'distanceUnit:unknown': '未知',
      'Pace': '配速',
      'Seconds Label': '秒',
      'shareMessage': 'Pacelator，即刻下载',
    },
  };

  static List<String> languages() => _localizedValues.keys.toList();

  String get title {
    return _localizedValues[locale.languageCode]!['title']!;
  }

  String get unit {
    return _localizedValues[locale.languageCode]!['unit']!;
  }

  String get raceType {
    return _localizedValues[locale.languageCode]!['Race Type']!;
  }

  String get distance {
    return _localizedValues[locale.languageCode]!['distance']!;
  }

  String get lightMode {
    return _localizedValues[locale.languageCode]!['Light Mode']!;
  }

  String get darkMode {
    return _localizedValues[locale.languageCode]!['Dark Mode']!;
  }

  String get minuteLabel {
    return _localizedValues[locale.languageCode]!['Minute Label']!;
  }

  String get secondsLabel {
    return _localizedValues[locale.languageCode]!['Seconds Label']!;
  }

  String get hourLabel {
    return _localizedValues[locale.languageCode]!['Hour Label']!;
  }

  String get estimateFinishTime {
    return _localizedValues[locale.languageCode]!['Estimated Finish Time']!;
  }

  String get calculate {
    return _localizedValues[locale.languageCode]!['Calculate']!;
  }

  String get results {
    return _localizedValues[locale.languageCode]!['Results']!;
  }

  String get splits {
    return _localizedValues[locale.languageCode]!['splits']!;
  }

  String get pace {
    return _localizedValues[locale.languageCode]!['Pace']!;
  }

  String get hhMMSS {
    return _localizedValues[locale.languageCode]!['hhMMSS']!;
  }

  String get lapNo {
    return _localizedValues[locale.languageCode]!['lapNo']!;
  }

  String get shareMessage {
    return _localizedValues[locale.languageCode]!['shareMessage']!;
  }

  String get newrathon {
    return _localizedValues[locale.languageCode]!['newrathon']!;
  }

  String get lapTime {
    return _localizedValues[locale.languageCode]!['lapTime']!;
  }

  String get lapDistance {
    return _localizedValues[locale.languageCode]!['lapDistance']!;
  }

  String getL10nByKey(String key) {
    return _localizedValues[locale.languageCode]![key]!;
  }
}

class MinimalLocalizationsDelegate
    extends LocalizationsDelegate<MinimalLocalizations> {
  const MinimalLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      MinimalLocalizations.languages().contains(locale.languageCode);

  @override
  Future<MinimalLocalizations> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of MinimalLocalizations.
    return SynchronousFuture<MinimalLocalizations>(
        MinimalLocalizations(locale));
  }

  @override
  bool shouldReload(MinimalLocalizationsDelegate old) => false;
}
