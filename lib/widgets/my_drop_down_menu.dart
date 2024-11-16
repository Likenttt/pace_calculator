import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:pacelator_toolbox/utils/enums.dart';
import 'package:pacelator_toolbox/utils/helpers.dart';
import 'package:easy_localization/easy_localization.dart';

class MyDropDownMenu<T> extends StatelessWidget {
  final T value;
  final List<T> items;
  final Function(T?) onChanged;
  const MyDropDownMenu({
    Key? key,
    required this.value,
    required this.items,
    required this.onChanged,
  }) : super(key: key);

  String _getText(T value) {
    return value.toString().split('.').last.firstCapital();
  }

  String getMenuText(T value, BuildContext context) {
    switch (T) {
      case RaceType _:
        return (value as RaceType).l10nKey.tr();
      case DistanceUnit _:
        return (value as DistanceUnit).l10nKey.tr();
      default:
        return _getText(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: DropdownButton<T>(
        borderRadius: BorderRadius.circular(12),
        value: value,
        icon: const Icon(EvaIcons.chevronDown),
        elevation: 3,
        underline: Container(
          height: 3,
          color: Theme.of(context).colorScheme.primary,
        ),
        onChanged: onChanged,
        items: items.map<DropdownMenuItem<T>>((T value) {
          return DropdownMenuItem<T>(
            value: value,
            child: Text(getMenuText(value, context)),
          );
        }).toList(),
      ),
    );
  }
}
