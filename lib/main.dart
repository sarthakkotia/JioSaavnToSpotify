import 'package:flutter/material.dart';
import 'package:itsamistake/Screens/homescree.dart';
import 'package:dynamic_color/dynamic_color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              bottomSheetTheme: const BottomSheetThemeData(
                  backgroundColor: Colors.transparent, elevation: 0),
              colorScheme: darkDynamic == null
                  ? ColorScheme.fromSeed(
                      seedColor: Colors.deepPurple, brightness: Brightness.dark)
                  : darkDynamic.copyWith(
                      background: Color.fromRGBO(29, 27, 30, 1)),
              useMaterial3: true,
            ),
            home: const HomeScreen(),
          );
        }
        ;
      },
    );
  }
}
