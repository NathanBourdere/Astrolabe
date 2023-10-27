import 'package:flutter/material.dart';
import 'package:festival/database.dart';
import 'package:festival/models/performance.dart';
import 'package:festival/artiste_page.dart';
import 'package:festival/scene_page.dart';

class PerformanceDetailsPage extends StatelessWidget {
  const PerformanceDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    final performanceId = arguments as int;

    return FutureBuilder<Performance>(
      future: DatabaseAstrolabe.instance.getPerformanceById(performanceId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            final performance = snapshot.data!;

            return Scaffold(
              appBar: AppBar(
                title: Text(performance.nomPerformance),
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
                    Text(
                      performance.nomPerformance,
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      '${performance.datePerformance} à ${performance.heureDebutPerformance} - ${performance.heureFinPerformance}',
                      style: const TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'La scène :',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () async {
                            final performances = await DatabaseAstrolabe
                                .instance
                                .getPerformancesByScene(performance.scene);
                            // ignore: use_build_context_synchronously
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ScenePage(
                                  scene: performance.scene,
                                  performances: performances,
                                ),
                              ),
                            );
                          },
                          title: Text(
                            performance.scene.getNomScene(),
                            style: const TextStyle(fontSize: 14),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Artistes:',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: performance.artistes.length,
                      itemBuilder: (context, index) {
                        final artiste = performance.artistes[index];
                        return ListTile(
                          onTap: () async {
                            final performances = await DatabaseAstrolabe
                                .instance
                                .getPerformancesByArtiste(artiste);
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
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text('Error: ${snapshot.error}'),
              ),
            );
          }
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
