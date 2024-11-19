import 'package:flutter/material.dart';
import 'package:pacelator_toolbox/controllers/theme_controller.dart';
import 'package:pacelator_toolbox/data/calculator.dart';
import 'package:pacelator_toolbox/pages/results_page.dart';
import 'package:pacelator_toolbox/utils/helpers.dart';
import 'package:pacelator_toolbox/utils/textStyles.dart';
import 'package:pacelator_toolbox/widgets/tile.dart';
import 'package:provider/provider.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:pacelator_toolbox/controllers/data_controller.dart';
import 'package:pacelator_toolbox/utils/enums.dart';
import 'package:pacelator_toolbox/widgets/my_drop_down_menu.dart';
import 'package:pacelator_toolbox/widgets/slider.dart';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:easy_localization/easy_localization.dart';

class PaceCalculatorPage extends StatefulWidget {
  const PaceCalculatorPage({super.key});

  @override
  State<PaceCalculatorPage> createState() => _PaceCalculatorPageState();
}

class _PaceCalculatorPageState extends State<PaceCalculatorPage> {
  @override
  Widget build(BuildContext context) {
    var dataController = Provider.of<DataController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('paceCalculatorTitle'.tr()),
        actions: [
          IconButton(
            tooltip: isThemeDark(context) ? 'lightMode'.tr() : 'darkMode'.tr(),
            icon: Icon(
              isThemeDark(context) ? EvaIcons.sunOutline : EvaIcons.moonOutline,
            ),
            onPressed: () =>
                Provider.of<ThemeController>(context, listen: false)
                    .toggleTheme(),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(6.0),
        children: [
          //! second container
          Tile(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'unit'.tr(),
                  style: MyTextStyles(context).cardTitle,
                ),
                MyDropDownMenu<DistanceUnit>(
                  items: DistanceUnit.values
                      .where((u) => u != DistanceUnit.unknown)
                      .toList(),
                  value: dataController.unit!,
                  onChanged: (value) => dataController.setUnit(value),
                ),
                const SizedBox(height: 8),
                Text(
                  'Race Type'.tr(),
                  style: MyTextStyles(context).cardTitle,
                ),
                MyDropDownMenu<RaceType>(
                  items: dataController.unit == DistanceUnit.metric
                      ? RaceType.metricTypes
                      : RaceType.statuteTypes,
                  value: dataController.raceType!,
                  onChanged: (value) => dataController.setRaceType(value),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'distance'.tr(),
                      style: MyTextStyles(context).cardTitle,
                    ),
                    Row(
                      children: [
                        Text(
                          dataController.distanceFormatted()[0],
                          style: MyTextStyles(context).homeCardValue,
                        ),
                        Text(
                          dataController.distanceFormatted()[1],
                          style: MyTextStyles(context).homeCardText,
                        ),
                      ],
                    ),
                  ],
                ),
                MyCustomSlider(
                  value: dataController.distance!,
                  minValue: RaceType.t1000m.distance,
                  maxValue: RaceType.t100k.distance,
                  onChanged: (value) => dataController.setDistance(value),
                ),
              ],
            ),
          ),
          Tile(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTabController(
                    length: 2,
                    initialIndex: dataController.getTabInitialIndex(),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          TabBar(
                            labelColor: const Color(0xff6750a4),
                            indicatorColor: const Color(0xff6750a4),
                            unselectedLabelColor: Colors.grey,
                            onTap: (value) => dataController.setTabMode(value),
                            tabs: [
                              Tab(text: 'estimateFinishTime'.tr()),
                              Tab(
                                  text:
                                      '${'Pace'.tr()}(${dataController.unit!.unit3.tr()})')
                            ],
                          ),
                          SizedBox(
                              height: 240, //height of TabBarView
                              // decoration: const BoxDecoration(
                              //     border: Border(
                              //         top: BorderSide(
                              //             color: Colors.grey, width: 0.2))),
                              child: TabBarView(children: <Widget>[
                                Container(
                                  child: showPicker(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 0),
                                    isInlinePicker: true,
                                    value: Time(
                                      hour: dataController
                                          .getFinishedHourMinuteTime()
                                          .hour,
                                      minute: dataController
                                          .getFinishedHourMinuteTime()
                                          .minute,
                                    ),
                                    onChange: (value) =>
                                        dataController.setFinishedTime(value),
                                    minuteInterval: TimePickerInterval.ONE,
                                    iosStylePicker: true,
                                    minHour: 0,
                                    displayHeader: false,
                                    isOnChangeValueMode: true,
                                    accentColor: const Color(0xff6750a4),
                                    maxHour: 23,
                                    hourLabel: 'hourLabel'.tr(),
                                    minuteLabel: 'minuteLabel'.tr(),
                                    is24HrFormat: true,
                                    focusMinutePicker: true,
                                    dialogInsetPadding:
                                        const EdgeInsets.symmetric(
                                            horizontal: 0.0, vertical: 0.0),
                                    context: context,
                                  ),
                                ),
                                Container(
                                  child: showPicker(
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 0),
                                    isInlinePicker: true,
                                    value: Time(
                                      hour: dataController
                                          .getPaceMinuteSecondTime()
                                          .hour,
                                      minute: dataController
                                          .getPaceMinuteSecondTime()
                                          .minute,
                                    ),
                                    onChange: (value) =>
                                        dataController.setPace(value),
                                    minuteInterval: TimePickerInterval
                                        .ONE, // Changed from MinuteInterval.ONE
                                    iosStylePicker: true,
                                    minHour: 0,
                                    blurredBackground: true,
                                    displayHeader: false,
                                    isOnChangeValueMode: true,
                                    accentColor: const Color(0xff6750a4),
                                    maxHour: 10,
                                    hourLabel: 'minuteLabel'.tr(),
                                    minuteLabel: 'secondsLabel'.tr(),
                                    is24HrFormat: true,
                                    focusMinutePicker: true,
                                    dialogInsetPadding:
                                        const EdgeInsets.symmetric(
                                            horizontal: 0.0, vertical: 0.0),
                                    context: context,
                                  ),
                                ),
                              ]))
                        ]))
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        tooltip: 'calculate'.tr(),
        heroTag: 'fab',
        icon: const Icon(Icons.calculate),
        label: Text('calculate'.tr()),
        onPressed: () {
          Calculator calculator = Calculator(
            unit: dataController.unit!,
            raceType: dataController.raceType!,
            distance: dataController.distance!,
            tabMode: dataController.getTabMode(),
            pace: dataController.getPaceMinuteSecondTime(),
            etf: dataController.getFinishedHourMinuteTime(),
          );

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultPage(
                  distance: dataController.distanceFormatted(),
                  unit: calculator.unit,
                  raceType: calculator.raceType,
                  estimateTimeFinished: calculator.estimatedTimeFinished(true),
                  averagePace: calculator.averagePace(),
                  splits: calculator.splits()),
            ),
          );
        },
      ),
    );
  }
}
