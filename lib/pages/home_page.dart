import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:macro_calculator/controllers/theme_controller.dart';
import 'package:macro_calculator/pages/pace_calculator_page.dart';
import 'package:macro_calculator/utils/helpers.dart';
import 'package:provider/provider.dart';
import 'package:macro_calculator/l10n/minimal_l10n.dart';
import 'package:macro_calculator/pages/gpx_converter/gpx_to_csv_page.dart';

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
        title: Text(MinimalLocalizations.of(context).title),
        actions: [
          IconButton(
            tooltip: isThemeDark(context)
                ? MinimalLocalizations.of(context).lightMode
                : MinimalLocalizations.of(context).darkMode,
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
          // Pace Calculator Tile
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const PaceCalculatorPage()),
            ),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.timer, size: 48),
                    const SizedBox(height: 8),
                    Text(
                      'Pace Calculator',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Calculate your pace, arrange your race',
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // GPX Converter Tile
          InkWell(
            onTap: () => _showGpxConverterOptions(context),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.transform, size: 48),
                    const SizedBox(height: 8),
                    Text(
                      'GPX Converter',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Convert a GPX to any format you need',
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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
                title: const Text('GPX to CSV'),
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
                title: const Text('GPX to FIT'),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: 导航到 GPX to FIT 页面
                },
              ),
              ListTile(
                leading: Icon(Icons.map),
                title: Text('GPX to KML'),
                onTap: () {
                  // Handle GPX to KML conversion
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.map_outlined),
                title: Text('GPX to KMZ'),
                onTap: () {
                  // Handle GPX to KMZ conversion
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.picture_as_pdf),
                title: Text('GPX to PDF'),
                onTap: () {
                  // Handle GPX to PDF conversion
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
