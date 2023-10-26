import 'package:festival/database.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'artistes_page.dart';
import 'billetterie_page.dart';
import 'calendrier.dart';
import 'home.dart';
import 'news_page.dart';
import 'tests.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  databaseFactory = databaseFactoryFfi;
  await DatabaseAstrolabe.initDB();
  TestsDatabaseInsert testsDatabaseInsert = TestsDatabaseInsert();
  testsDatabaseInsert.insertAll();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Astrolabe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Astrolabe'),
      routes: {
        '/artistes': (context) => ArtistesPage(),
        '/news': (context) => NewsPage(),
        '/billetterie': (context) => const BilletteriePage(),
        '/calendrier': (context) => const CalendarApp(),
      },
    );
  }
}
