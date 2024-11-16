import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pacelator_toolbox/controllers/theme_controller.dart';
import 'package:pacelator_toolbox/pages/pace_calculator_page.dart';
import 'package:pacelator_toolbox/utils/helpers.dart';
import 'package:provider/provider.dart';
import 'package:pacelator_toolbox/pages/gpx_converter/gpx_to_csv_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('title'.tr()),
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
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _buildTile(
            context,
            icon: Icons.timer,
            title: 'paceCalculator'.tr(),
            description: 'paceCalculatorDesc'.tr(),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const PaceCalculatorPage()),
            ),
          ),
          _buildTile(
            context,
            icon: Icons.transform,
            title: 'gpxConverter'.tr(),
            description: 'gpxConverterDesc'.tr(),
            onTap: () => _showGpxConverterOptions(context),
          ),
        ],
      ),
    );
  }

  Widget _buildTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48),
              const SizedBox(height: 8),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showGpxConverterOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.file_present),
                title: Text('gpxToCsv'.tr()),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GpxToCsvPage()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.fitness_center),
                title: Text('gpxToFit'.tr()),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: 导航到 GPX to FIT 页面
                },
              ),
              ListTile(
                leading: const Icon(Icons.map),
                title: Text('gpxToKml'.tr()),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.map_outlined),
                title: Text('gpxToKmz'.tr()),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.picture_as_pdf),
                title: Text('gpxToPdf'.tr()),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.map),
                title: Text('gpxToTcx'.tr()),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.map),
                title: Text('gpxCoordinateConverter'.tr()),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
