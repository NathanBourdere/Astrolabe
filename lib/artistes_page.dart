import 'package:festival/artiste_page.dart';
import 'package:flutter/material.dart';
import 'package:festival/database.dart';
import 'package:festival/models/artiste.dart';
import 'package:festival/models/performance.dart';
import 'package:festival/navbar.dart';

class ArtistesPage extends StatelessWidget {
  const ArtistesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        title: const Text('Artistes'),
      ),
      body: FutureBuilder<List<Artiste>>(
        future: DatabaseAstrolabe.instance.getArtistes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final artistes = snapshot.data ?? [];
            return ListView.builder(
              itemCount: artistes.length,
              itemBuilder: (context, index) {
                final artiste = artistes[index];
                return ListTile(
                  title: Text(artiste.nomArtiste),
                  onTap: () async {
                    // Utilisez DatabaseAstrolabe.instance pour accéder à la base de données
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
                );
              },
            );
          }
        },
      ),
    );
  }
}
