import 'package:hive_flutter/hive_flutter.dart';
import 'package:pacelator_toolbox/controllers/data_controller.dart';
import 'package:pacelator_toolbox/controllers/theme_controller.dart';
import 'package:pacelator_toolbox/pages/home_page.dart';
import 'package:pacelator_toolbox/pages/gpx_quick_converter_page.dart';
import 'package:flutter/material.dart';
import 'package:pacelator_toolbox/utils/color_schemes.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';

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

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    // 监听文件打开事件
    ReceiveSharingIntent.instance
        .getInitialMedia()
        .then((List<SharedMediaFile>? files) {
      if (files != null && files.isNotEmpty) {
        _handleOpenedFile(files.first.path);
      }
    });

    // 监听应用运行时的文件打开
    ReceiveSharingIntent.instance
        .getMediaStream()
        .listen((List<SharedMediaFile> files) {
      if (files.isNotEmpty) {
        _handleOpenedFile(files.first.path);
      }
    });
  }

  void _handleOpenedFile(String filePath) {
    // 处理打开的 GPX 文件
    if (filePath.toLowerCase().endsWith('.gpx')) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                GpxQuickConverterPage(initialFilePath: filePath)),
      );
    }
  }

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
            home: const HomePage(),
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
