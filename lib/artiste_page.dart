import 'package:festival/models/artiste.dart';
import 'package:festival/models/performance.dart';
import 'package:flutter/material.dart';
import 'package:festival/database.dart';

class PageArtiste extends StatelessWidget {
  final Artiste artiste;
  final List<Performance> performances;

  const PageArtiste(
      {Key? key, required this.artiste, required this.performances})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Performance>>(
      future: DatabaseAstrolabe.instance.getPerformancesByArtiste(artiste),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: Text(artiste.nomArtiste),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text(artiste.nomArtiste),
            ),
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          final performancesArtiste = snapshot.data!;

          return Scaffold(
            appBar: AppBar(
              title: Text(artiste.nomArtiste),
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
                  Image.network(artiste.imageArtiste),
                  Text(
                    artiste.nomArtiste,
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    artiste.descriptionArtiste,
                    style: const TextStyle(fontSize: 16),
                  ),
                  // ... other artiste details
                  const SizedBox(height: 16),
                  const Text(
                    "Performances de l'artiste : ",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: performancesArtiste.length,
                    itemBuilder: (context, index) {
                      final performance = performancesArtiste[index];
                      return ListTile(
                        title: Text(performance.nomPerformance),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/performance/',
                            arguments: performance.idPerformance,
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
