import 'package:festival/artiste_page.dart';
import 'package:festival/database.dart';
import 'package:festival/main.dart';
import 'package:festival/models/artiste.dart';
import 'package:festival/models/performance.dart';
import 'package:festival/scene_page.dart';
import 'package:flutter/material.dart';

class PerformanceDetailsPage extends StatelessWidget {
  final Performance performance;

  const PerformanceDetailsPage({Key? key, required this.performance})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(performance.nomPerformance),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              // Navigate to the home page
              Navigator.pushNamed(context, '/');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              performance.nomPerformance,
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              '${performance.datePerformance} à ${performance.heureDebutPerformance} - ${performance.heureFinPerformance}',
              style: const TextStyle(fontSize: 14),
            ),
            // Show the scene and make a link to it
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScenePage(
                        scene: performance.scene,
                        performances: DatabaseAstrolabe.instance
                            .getPerformancesByScene(performance.scene)),
                  ),
                );
              },
              title: Text(
                performance.scene.nomScene,
                style: const TextStyle(fontSize: 14, color: Colors.blue),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Artistes:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: performance.artistes.length,
              itemBuilder: (context, index) {
                final artiste = performance.artistes[index];
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PageArtiste(
                          artiste: artiste,
                          performances: DatabaseAstrolabe.instance
                              .getPerformancesByArtiste(artiste),
                        ),
                      ),
                    );
                  },
                  title: Text(
                    artiste.nomArtiste,
                    style: const TextStyle(fontSize: 14),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
