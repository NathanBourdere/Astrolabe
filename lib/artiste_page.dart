import 'dart:io';

import 'package:festival/models/artiste.dart';
import 'package:festival/models/configuration.dart';
import 'package:festival/models/performance.dart';
import 'package:flutter/material.dart';
import 'package:festival/database.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
              title: Text(artiste.nom),
              actions: [
                IconButton(
                  icon: const Icon(Icons.home),
                  onPressed: () {
                    Navigator.pushNamed(context, '/');
                  },
                ),
              ],
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
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 250,
                        width: double.infinity,
                        child: Image.file(
                          File(artiste.image),
                          fit: BoxFit.cover,
                          height: 250,
                          width: double.infinity,
                        ),
                      ),
                      Container(
                        height: 250,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.white,
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 30,
                        left: 10,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: Text(
                          artiste.nom,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius:
                          BorderRadius.circular(12), // Arrondir les bords
                    ),
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
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
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius:
                          BorderRadius.circular(12), // Arrondir les bords
                    ),
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment:
                              Alignment.topLeft, // Aligner en haut à gauche
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
                  const SizedBox(height: 16),
                  Container(
                    margin: const EdgeInsets.all(10),
                    width: double.infinity, // Pour prendre toute la largeur
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
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
