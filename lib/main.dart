// ignore_for_file: prefer_const_constructors

import 'package:festival/database.dart';
import 'package:festival/models/configuration.dart';
import 'package:festival/models/modifications.dart';
import 'package:festival/performance.dart';
import 'package:festival/performances.dart';
import 'package:festival/performances_tags.dart';
import 'package:festival/scenes_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: unused_import
import 'package:flutter/services.dart' show AssetManifest;
import 'artistes_page.dart';
import 'billetterie_page.dart';
import 'home.dart';
import 'news_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  databaseFactory = databaseFactoryFfi;
  await DatabaseAstrolabe.initDB();
  await Modifications.updateModifications();
  TextStyle textStyle =
      GoogleFonts.getFont('Roboto', textStyle: const TextStyle(fontSize: 16));
  Configuration configuration =
      await DatabaseAstrolabe.instance.getConfiguration();
  runApp(
    ChangeNotifierProvider<ValueNotifier<Configuration>>(
      create: (_) => ValueNotifier<Configuration>(configuration),
      child: MyApp(
        textStyle: textStyle,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final TextStyle textStyle;

  const MyApp({Key? key, required this.textStyle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final configuration =
        Provider.of<ValueNotifier<Configuration>>(context).value;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Astrolabe',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 208, 255, 0)),
        scaffoldBackgroundColor: configuration.getBackgroundColor,
        useMaterial3: true,
        textTheme: TextTheme(
          bodyLarge: textStyle,
        ),
      ),
      home: const MyHomePage(title: 'Astrolabe'),
      routes: {
        '/artistes': (context) => const ArtistesPage(),
        '/news': (context) => const NewsPage(),
        '/billetterie': (context) => const BilletteriePage(),
        '/performances': (context) => const PerformancesPage(),
        '/performance/': (context) => const PerformanceDetailsPage(),
        '/performances_tags': (context) => const PerformancesTagPage(),
        '/scenes': (context) => const ScenesPage(),
      },
    );
  }
}
