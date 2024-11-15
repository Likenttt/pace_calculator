import 'package:flutter/material.dart';

import 'package:macro_calculator/utils/textStyles.dart';
import 'package:macro_calculator/widgets/tile.dart';
import 'package:macro_calculator/l10n/minimal_l10n.dart';

class FooterTile extends StatelessWidget {
  const FooterTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tile(
      child: Column(
        children: [
          const Icon(Icons.run_circle_outlined),
          Text(MinimalLocalizations.of(context).newrathon,
              style: MyTextStyles(context).resultCardText),
        ],
      ),
    );
  }
}
