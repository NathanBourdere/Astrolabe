import 'package:festival/models/artiste.dart';
import 'package:festival/models/configuration.dart';
import 'package:festival/models/performance.dart';
import 'package:flutter/material.dart';
import 'package:festival/database.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

class PageArtiste extends StatelessWidget {
  final Artiste artiste;
  final List<Performance> performances;

  const PageArtiste({Key? key, required this.artiste, required this.performances})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Configuration configuration =
        Provider.of<ValueNotifier<Configuration>>(context).value;

    return FutureBuilder<List<Performance>>(
      future: DatabaseAstrolabe.instance.getPerformancesByArtiste(artiste),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          final performancesArtiste = snapshot.data!;

          return Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 250,
                  backgroundColor: Colors.transparent,
                  flexibleSpace: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.file(
                          File(artiste.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              configuration.getBackgroundColor,
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: Text(
                          artiste.nom,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Prochaines performances :",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: configuration.getMainColor,
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: performancesArtiste.length,
                          itemBuilder: (context, index) {
                            final performance = performancesArtiste[index];
                            return ListTile(
                              title: Text(
                                performance.nom,
                              ),
                              subtitle: Text(
                                '${performance.date} à ${performance.heure_debut} - ${performance.heure_fin}',
                                style: GoogleFonts.getFont(
                                  configuration.getpoliceEcriture,
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                    color: configuration.getFontColor,
                                  ),
                                ),
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
                ),
                SliverToBoxAdapter(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "A propos :",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: configuration.getMainColor,
                            ),
                          ),
                        ),
                        Text(
                          artiste.description,
                          style: TextStyle(
                            fontSize: 16,
                            color: configuration.getMainColor,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Réseaux sociaux :",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: configuration.getMainColor,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const FaIcon(FontAwesomeIcons.facebook),
                              onPressed: () {
                                Uri url = Uri.parse(artiste.facebook);
                                launchUrl(url);
                              },
                            ),
                            IconButton(
                              icon: const FaIcon(FontAwesomeIcons.youtube),
                              onPressed: () {
                                Uri url = Uri.parse(artiste.youtube);
                                launchUrl(url);
                              },
                            ),
                            IconButton(
                              icon: const FaIcon(FontAwesomeIcons.instagram),
                              onPressed: () {
                                Uri url = Uri.parse(artiste.instagram);
                                launchUrl(url);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
