import 'package:macro_calculator/controllers/data_controller.dart';
import 'package:macro_calculator/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => DataController())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Macro Calculator',
        home: HomePage(),
        theme: ThemeData(
          primaryColor: Colors.red,
          accentColor: Colors.redAccent,
          brightness: Brightness.light,
        ),
      ),
    );
  }
}
