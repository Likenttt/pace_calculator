import 'dart:io';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:macro_calculator/utils/enums.dart';
import 'package:macro_calculator/widgets/result_tile.dart';
import 'package:macro_calculator/widgets/split_tile.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:macro_calculator/l10n/minimal_l10n.dart';

class RunSplit {
  final String splitNo;
  final String splitDistance;
  final String splitPace;
  final String splitTime;

  RunSplit(
      {required this.splitNo,
      required this.splitDistance,
      required this.splitPace,
      required this.splitTime});
}

class ResultPage extends StatelessWidget {
  ResultPage({
    required this.averagePace,
    required this.estimateTimeFinished,
    required this.splits,
    required this.raceType,
    required this.unit,
  });
  final String estimateTimeFinished;
  final String averagePace;
  final RaceType raceType;
  final DistanceUnit unit;
  final List<RunSplit> splits;
  @override
  Widget build(BuildContext context) {
    ScreenshotController screenshotController = ScreenshotController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${MinimalLocalizations.of(context).getL10nByKey(raceType.l10nKey)} ${MinimalLocalizations.of(context).results}'),
        leading: IconButton(
          icon: Icon(EvaIcons.chevronLeft),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.all(6.0),
          children: [
            Screenshot(
              controller: screenshotController,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ResultTile(
                    title: MinimalLocalizations.of(context).estimateFinishTime,
                    value: estimateTimeFinished,
                    units: MinimalLocalizations.of(context).hhMMSS,
                  ),
                  ResultTile(
                    title: MinimalLocalizations.of(context).pace,
                    value: averagePace,
                    units: MinimalLocalizations.of(context)
                        .getL10nByKey(unit.unit3),
                  ),
                  SplitTile(
                      unit: unit,
                      title: MinimalLocalizations.of(context).splits,
                      splits: splits)
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'fab',
        tooltip: 'share',
        child: Icon(Icons.share_rounded),
        onPressed: () => shareScreenshot(screenshotController),
      ),
    );
  }

  void shareScreenshot(ScreenshotController key) async {
    var unit8List = await key.capture();
    String tempPath = (await getTemporaryDirectory()).path;
    File file = File('$tempPath/img.png');
    await file.writeAsBytes(unit8List!);
    await Share.shareFiles(
      [file.path],
      text: 'Newrathon Pace Calculator.\n' +
          'download now: https://play.google.com/store/apps/details?id=com.newrathon.pace_calculator',
    );
  }
}
