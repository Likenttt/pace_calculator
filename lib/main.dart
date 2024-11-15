import 'package:hive_flutter/hive_flutter.dart';
import 'package:macro_calculator/controllers/data_controller.dart';
import 'package:macro_calculator/controllers/theme_controller.dart';
import 'package:macro_calculator/pages/home_page.dart';
import 'package:macro_calculator/l10n/minimal_l10n.dart';
import 'package:flutter/material.dart';
import 'package:macro_calculator/utils/color_schemes.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('data');
  await Hive.openBox('theme');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DataController()),
        ChangeNotifierProvider(create: (_) => ThemeController()),
      ],
      child: Consumer<ThemeController>(
        builder: (context, theme, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateTitle: (BuildContext context) =>
                MinimalLocalizations.of(context).title,
            localizationsDelegates: const [
              MinimalLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''), // English, no country code
              Locale('zh', ''), // Spanish, no country code
            ],
            home: HomePage(),
            theme: ThemeData(
              scaffoldBackgroundColor: lightColorScheme.surface,
              useMaterial3: true,
              colorScheme: lightColorScheme,
            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: darkColorScheme.surface,
              useMaterial3: true,
              colorScheme: darkColorScheme,
            ),
            themeMode: theme.themeMode,
          );
        },
      ),
    );
  }
}
