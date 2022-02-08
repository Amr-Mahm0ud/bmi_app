import 'package:bmi_app/provider.dart';
import 'package:bmi_app/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MyProv(),
        builder: (context, _) {
          final _themeProvider = Provider.of<MyProv>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: _themeProvider.themeMode == ThemeMode.light
                ? MyThemes.lightTheme
                : MyThemes.darkTheme,
            home: const MySplashScreen(),
          );
        });
  }
}
