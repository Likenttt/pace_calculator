import 'package:hive_flutter/hive_flutter.dart';
import 'package:macro_calculator/controllers/data_controller.dart';
import 'package:macro_calculator/controllers/theme_controller.dart';
import 'package:macro_calculator/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:macro_calculator/utils/color_schemes.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('data');
  await Hive.openBox('theme');

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('zh')],
      path: 'lib/assets/translations', // 修改为正确的路径
      fallbackLocale: Locale('en'),
      child: MyApp(),
    ),
  );
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
            onGenerateTitle: (context) => 'title'.tr(),
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
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
