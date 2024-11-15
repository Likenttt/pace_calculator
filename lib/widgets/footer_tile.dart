import 'package:flutter/material.dart';
import 'package:macro_calculator/utils/textStyles.dart';

import 'package:macro_calculator/widgets/tile.dart';
import 'package:easy_localization/easy_localization.dart';

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
          Text('newrathon'.tr(), style: MyTextStyles(context).resultCardText),
        ],
      ),
    );
  }
}
