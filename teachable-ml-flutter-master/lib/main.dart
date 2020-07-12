import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teachable_ml/pages/home_page.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

     return new DynamicTheme(
      data: (brightness) => new ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.deepOrange,
        accentColor: Colors.deepOrange,
        primarySwatch: Colors.deepOrange,
      ),
      themedWidgetBuilder: (context, theme) {
        return new MaterialApp(
          title: 'Calculadora de Juros',
          theme: theme,
          debugShowCheckedModeBanner: false,
          home: HomePage(),
       );
      }
    );
  }

}