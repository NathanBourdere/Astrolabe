import 'package:festival/models/artiste.dart';
import 'package:festival/models/configuration.dart';
import 'package:festival/models/performance.dart';
import 'package:flutter/material.dart';
import 'package:festival/database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PageArtiste extends StatelessWidget {
  final Artiste artiste;
  final List<Performance> performances;

  const PageArtiste(
      {Key? key, required this.artiste, required this.performances})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Configuration configuration =
        Provider.of<ValueNotifier<Configuration>>(context).value;
    return FutureBuilder<List<Performance>>(
      future: DatabaseAstrolabe.instance.getPerformancesByArtiste(artiste),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                artiste.nom,
              ),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text(artiste.nom,
                  style: TextStyle(color: configuration.getFontColor)),
            ),
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          final performancesArtiste = snapshot.data!;

          return Scaffold(
            appBar: AppBar(
              title: Text(
                artiste.nom,
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.home),
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Image.network(artiste.image),
                  Text(
                    artiste.description,
                    style: TextStyle(
                        fontSize: 16, color: configuration.getMainColor),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Performances de l'artiste : ",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: configuration.getMainColor),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: performancesArtiste.length,
                    itemBuilder: (context, index) {
                      final performance = performancesArtiste[index];
                      return ListTile(
                        title: Text(performance.nom,
                            style:
                                TextStyle(color: configuration.getFontColor)),
                        subtitle: Text(
                          '${performance.date} à ${performance.heure_debut} - ${performance.heure_fin}',
                          style: GoogleFonts.getFont(
                              configuration.getpoliceEcriture,
                              textStyle: TextStyle(
                                  fontSize: 14,
                                  color: configuration.getFontColor)),
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/performance/',
                            arguments: performance.id,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
