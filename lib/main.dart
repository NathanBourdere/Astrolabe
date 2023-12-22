import 'package:festival/api/firebase_api.dart';
import 'package:festival/database.dart';
import 'package:festival/menu_page.dart';
import 'package:festival/models/configuration.dart';
import 'package:festival/models/modifications.dart';
import 'package:festival/page_informations.dart';
import 'package:festival/performance.dart';
import 'package:festival/performances_tags.dart';
import 'package:festival/scenes_page.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:google_fonts/google_fonts.dart';
import 'artistes_page.dart';
import 'billetterie_page.dart';
import 'home.dart';
import 'news_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:connectivity/connectivity.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  databaseFactory = databaseFactoryFfi;
  await DatabaseAstrolabe.initDB();

  TextStyle textStyle =
      GoogleFonts.getFont('Roboto', textStyle: const TextStyle(fontSize: 16));

  // Check for internet connectivity
  var connectivityResult = await Connectivity().checkConnectivity();
  bool isConnected = (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi);

  if (isConnected) {
    await Modifications.updateModifications();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseApi().initNotifications();
  }
    Configuration configuration =
      await DatabaseAstrolabe.instance.getConfiguration();

  runApp(
    MyApp(
      configuration: configuration,
      textStyle: textStyle,
    ),
  );
}

class MyApp extends StatelessWidget {
  final Configuration configuration;
  final TextStyle textStyle;

  const MyApp({
    Key? key,
    required this.configuration,
    required this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Astrolabe',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 208, 255, 0)),
        scaffoldBackgroundColor: configuration.getBackgroundColor,
        useMaterial3: true,
        textTheme: TextTheme(
          bodyLarge: textStyle,
        ),
      ),
      home: MyHomePage(title: 'Astrolabe', configuration: configuration),
      routes: {
        '/artistes': (context) => ArtistesPage(
              configuration: configuration,
            ),
        '/news': (context) => NewsPage(),
        '/billetterie': (context) => const BilletteriePage(),
        '/performances': (context) => PerformancesPage(
              configuration: configuration,
            ),
        '/performance/': (context) => PerformanceDetailsPage(
              configuration: configuration,
            ),
        '/performances_tags': (context) => PerformancesTagPage(
              configuration: configuration,
            ),
        '/scenes': (context) => ScenesPage(
              configuration: configuration,
            ),
        '/informations': (context) => InformationsPage(
              configuration: configuration,
            ),
      },
    );
  }
}
