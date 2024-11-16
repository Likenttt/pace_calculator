import 'package:flutter/material.dart';

import 'package:pacelator_toolbox/utils/textStyles.dart';
import 'package:pacelator_toolbox/widgets/tile.dart';

class ResultTile extends StatelessWidget {
  const ResultTile({
    super.key,
    required this.title,
    required this.value,
    required this.units,
  });

  final String title;
  final String value;
  final String units;

  @override
  Widget build(BuildContext context) {
    return Tile(
      child: Column(
        children: [
          Text(value, style: MyTextStyles(context).resultCardValue),
          Text(units, style: MyTextStyles(context).resultCardUnit),
          Text(title, style: MyTextStyles(context).resultCardText),
        ],
      ),
    );
  }
}
