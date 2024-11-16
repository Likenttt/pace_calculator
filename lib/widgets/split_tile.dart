import 'package:flutter/material.dart';
import 'package:pacelator_toolbox/pages/results_page.dart';
import 'package:pacelator_toolbox/utils/enums.dart';

import 'package:pacelator_toolbox/utils/textStyles.dart';
import 'package:pacelator_toolbox/widgets/tile.dart';
import 'package:easy_localization/easy_localization.dart';

class SplitTile extends StatelessWidget {
  const SplitTile({
    super.key,
    required this.title,
    required this.unit,
    required this.splits,
  });

  final String title;
  final DistanceUnit unit;
  final List<RunSplit> splits;

  List<TableRow> getTableRows(BuildContext context) {
    List<TableRow> list = [];
    list.add(getTableHeaders(context));
    list.addAll(getTableContent(context));
    return list;
  }

  List<TableRow> getTableContent(BuildContext context) {
    List<TableRow> rows = [];
    for (var split in splits) {
      TableRow row = TableRow(
        children: <Widget>[
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text(split.splitNo,
                style: MyTextStyles(context).resultCardUnit,
                textAlign: TextAlign.center),
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text(split.splitTime,
                style: MyTextStyles(context).resultCardUnit,
                textAlign: TextAlign.center),
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: Text(split.splitDistance,
                style: MyTextStyles(context).resultCardUnit,
                textAlign: TextAlign.center),
          ),
        ],
      );
      rows.add(row);
    }
    return rows;
  }

  TableRow getTableHeaders(BuildContext context) {
    return TableRow(
      children: <Widget>[
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Text('lapNo'.tr(),
              style: MyTextStyles(context).resultCardUnit,
              textAlign: TextAlign.center),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Text('lapTime'.tr(),
              style: MyTextStyles(context).resultCardUnit,
              textAlign: TextAlign.center),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Text('${'lapDistance'.tr()}(${unit.unit2})',
              style: MyTextStyles(context).resultCardUnit,
              textAlign: TextAlign.center),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    List<TableRow> tableRows = getTableRows(context);
    return Tile(
      child: Column(
        children: [
          Text(title, style: MyTextStyles(context).resultCardText),
          Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: tableRows),
        ],
      ),
    );
  }
}
