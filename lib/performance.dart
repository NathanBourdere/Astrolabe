import 'package:festival/models/configuration.dart';
import 'package:flutter/material.dart';
import 'package:festival/database.dart';
import 'package:festival/models/performance.dart';
import 'package:festival/artiste_page.dart';
import 'package:festival/scene_page.dart';
import 'package:provider/provider.dart';

class PerformanceDetailsPage extends StatelessWidget {
  const PerformanceDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    final performanceId = arguments as int;
    Configuration configuration =
        Provider.of<ValueNotifier<Configuration>>(context).value;

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
                      style: TextStyle(
                          fontSize: 20, color: configuration.getMainColor),
                    ),
                    Text(
                      '${performance.datePerformance} à ${performance.heureDebutPerformance} - ${performance.heureFinPerformance}',
                      style: TextStyle(
                          fontSize: 14, color: configuration.getMainColor),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'La scène :',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: configuration.getMainColor),
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
                            style: TextStyle(
                                fontSize: 14,
                                color: configuration.getFontColor),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Artistes:',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: configuration.getMainColor),
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
                            style: TextStyle(
                                fontSize: 14,
                                color: configuration.getFontColor),
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
