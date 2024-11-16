import 'dart:io';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:pacelator_toolbox/utils/enums.dart';
import 'package:pacelator_toolbox/widgets/footer_tile.dart';
import 'package:pacelator_toolbox/widgets/header_tile.dart';
import 'package:pacelator_toolbox/widgets/result_tile.dart';
import 'package:pacelator_toolbox/widgets/split_tile.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:easy_localization/easy_localization.dart';

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
    return [raceType.l10nKey.tr(), ''];
  }

  List<Widget> getScreenshotContent(BuildContext context) {
    List<String> distanceInfo = getDistanceInfo(raceType, context);
    return [
      HeaderTile(title: '${distanceInfo[0]} ${distanceInfo[1]}'),
      ResultTile(
        title: 'estimateFinishTime'.tr(),
        value: estimateTimeFinished,
        units: 'hhMMSS'.tr(),
      ),
      ResultTile(
        title: 'pace'.tr(),
        value: averagePace,
        units: unit.unit3.tr(),
      ),
      SplitTile(unit: unit, title: 'splits'.tr(), splits: splits),
      const FooterTile()
    ];
  }

  @override
  Widget build(BuildContext context) {
    ScreenshotController screenshotController = ScreenshotController();
    List<Widget> screenshotContent = getScreenshotContent(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('results'.tr()),
        leading: IconButton(
          icon: const Icon(EvaIcons.chevronLeft),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
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
