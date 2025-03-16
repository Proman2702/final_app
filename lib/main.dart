import 'package:flutter/material.dart';
import 'package:final_app/features/home/home_page.dart';
import 'package:final_app/features/stats/stats_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomePage(),
        '/stats': (context) => const StatsPage(),
      },
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: 'Jura',
          textTheme: TextTheme(
            bodyMedium: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
          )),
    );
  }
}
