import 'dart:io';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:macro_calculator/utils/enums.dart';
import 'package:macro_calculator/widgets/footer_tile.dart';
import 'package:macro_calculator/widgets/header_tile.dart';
import 'package:macro_calculator/widgets/result_tile.dart';
import 'package:macro_calculator/widgets/split_tile.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:macro_calculator/l10n/minimal_l10n.dart';
import 'package:intl/intl.dart';

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
  const ResultPage({
    super.key,
    required this.averagePace,
    required this.estimateTimeFinished,
    required this.splits,
    required this.raceType,
    required this.unit,
    required this.distance,
  });
  final String estimateTimeFinished;
  final String averagePace;
  final List<String> distance;
  final RaceType raceType;
  final DistanceUnit unit;
  final List<RunSplit> splits;

  List<String> getDistanceInfo(RaceType raceType, BuildContext context) {
    if (raceType == RaceType.tCustomized) {
      return distance;
    }
    return [
      MinimalLocalizations.of(context).getL10nByKey(raceType.l10nKey),
      ''
    ];
  }

  List<Widget> getScreenshotContent(BuildContext context) {
    List<String> distanceInfo = getDistanceInfo(raceType, context);
    return [
      HeaderTile(title: '${distanceInfo[0]} ${distanceInfo[1]}'),
      ResultTile(
        title: MinimalLocalizations.of(context).estimateFinishTime,
        value: estimateTimeFinished,
        units: MinimalLocalizations.of(context).hhMMSS,
      ),
      ResultTile(
        title: MinimalLocalizations.of(context).pace,
        value: averagePace,
        units: MinimalLocalizations.of(context).getL10nByKey(unit.unit3),
      ),
      SplitTile(
          unit: unit,
          title: MinimalLocalizations.of(context).splits,
          splits: splits),
      const FooterTile()
    ];
  }

  @override
  Widget build(BuildContext context) {
    ScreenshotController screenshotController = ScreenshotController();
    List<Widget> screenshotContent = getScreenshotContent(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(MinimalLocalizations.of(context).results),
        leading: IconButton(
          icon: const Icon(EvaIcons.chevronLeft),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        child: ListView(
          padding: const EdgeInsets.all(6.0),
          children: [
            Screenshot(
              controller: screenshotController,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: screenshotContent,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'fab',
        tooltip: 'share',
        child: const Icon(Icons.share_rounded),
        onPressed: () =>
            shareScreenshot(screenshotController, context, screenshotContent),
      ),
    );
  }

  void shareScreenshot(ScreenshotController key, BuildContext context,
      List<Widget> screenshotContent) async {
    // screenshotContent.add();
    var unit8List = await key.capture();
    String tempPath = (await getTemporaryDirectory()).path;
    String timestamp = DateFormat('yyyy-MMdd-HHmmss').format(DateTime.now());
    File file = File('$tempPath/img_$timestamp.png');
    await file.writeAsBytes(unit8List!);
    await Share.shareXFiles([XFile(file.path)]);
  }
}
