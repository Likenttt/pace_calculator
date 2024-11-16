import 'package:flutter/material.dart';

import 'package:pacelator_toolbox/utils/textStyles.dart';
import 'package:pacelator_toolbox/widgets/tile.dart';

class HeaderTile extends StatelessWidget {
  const HeaderTile({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Tile(
      child: Column(
        children: [
          Text(title, style: MyTextStyles(context).resultCardValue),
        ],
      ),
    );
  }
}
