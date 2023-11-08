import 'package:festival/models/configuration.dart';
import 'package:festival/performance.dart';
import 'package:flutter/material.dart';
import 'package:festival/models/performance.dart';
import 'package:festival/models/scene.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

@immutable
class ScenePage extends StatelessWidget {
  final Scene scene;
  final List<Performance> performances;

  const ScenePage({Key? key, required this.scene, required this.performances})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Configuration configuration =
        Provider.of<ValueNotifier<Configuration>>(context).value;
    return Scaffold(
      appBar: AppBar(title: Text(scene.nom), actions: [
        IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            // Navigate to the home page
            Navigator.pushNamed(context, '/');
          },
        ),
      ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(scene.image),
            Text(
              'Événements :',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: configuration.getMainColor),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: performances.length,
              itemBuilder: (context, index) {
                final performance = performances[index];
                return ListTile(
                  title: Text(performance.nom,
                      style: TextStyle(
                          fontSize: 14, color: configuration.getFontColor)),
                  subtitle: Text(
                    '${performance.date} à ${performance.heure_debut} - ${performance.heure_fin}',
                    style: GoogleFonts.getFont(configuration.getpoliceEcriture,
                        textStyle: TextStyle(
                            fontSize: 14, color: configuration.getFontColor)),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/performance/',
                        arguments: performance.id);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
