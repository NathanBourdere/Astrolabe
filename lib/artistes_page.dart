import 'package:festival/artiste_page.dart';
import 'package:festival/models/configuration.dart';
import 'package:flutter/material.dart';
import 'package:festival/database.dart';
import 'package:festival/models/artiste.dart';
import 'package:festival/models/performance.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class ArtistesPage extends StatelessWidget {
  const ArtistesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Configuration configuration =
        Provider.of<ValueNotifier<Configuration>>(context).value;
    print(configuration.couleurBackground);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Artistes'),
      ),
      body: FutureBuilder<List<Artiste>>(
        future: DatabaseAstrolabe.instance.getArtistes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final artistes = snapshot.data ?? [];

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 artistes par ligne
              ),
              itemCount: artistes.length,
              itemBuilder: (context, index) {
                final artiste = artistes[index];
                return GestureDetector(
                  onTap: () async {
                    List<Performance> performances = await DatabaseAstrolabe
                        .instance
                        .getPerformancesByArtiste(artiste);
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PageArtiste(
                          artiste: artiste,
                          performances: performances,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(File(artiste.image)),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomCenter,
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            artiste.nom,
                            style: GoogleFonts.getFont(
                              configuration.getpoliceEcriture,
                              textStyle: TextStyle(
                                fontSize: 18,
                                color: configuration.getFontColor,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
