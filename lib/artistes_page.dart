import 'package:festival/artiste_page.dart';
import 'package:festival/models/artiste.dart';
import 'package:festival/models/performance.dart';
import 'package:festival/navbar.dart';
import 'package:flutter/material.dart';

class ArtistesPage extends StatelessWidget {
  final List<Artiste> artistes;

  const ArtistesPage({Key? key, required this.artistes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        title: const Text('Artistes'),
      ),
      body: ListView.builder(
        itemCount: artistes.length,
        itemBuilder: (context, index) {
          final artiste = artistes[index];
          return ListTile(
            title: Text(artiste.nomArtiste),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PageArtiste(
                    artiste: artiste,
                    performances: getPerformancesByArtiste(artiste),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
