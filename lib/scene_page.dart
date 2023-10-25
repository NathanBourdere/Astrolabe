import 'package:festival/performance.dart';
import 'package:flutter/material.dart';
import 'package:festival/models/performance.dart';
import 'package:festival/models/scene.dart';

@immutable
class ScenePage extends StatelessWidget {
  final Scene scene;
  final List<Performance> performances;

  const ScenePage({Key? key, required this.scene, required this.performances})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(scene.nomScene), actions: [
        IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            // Navigate to the home page
            Navigator.pushNamed(context, '/');
          },
        ),
      ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(scene.imageScene),
            Text(
              'Nom : ${scene.nomScene}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Événements :',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: performances.length,
              itemBuilder: (context, index) {
                final performance = performances[index];
                return ListTile(
                  title: Text(performance.nomPerformance),
                  onTap: () {
                    // Afficher la page de la performance
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PerformanceDetailsPage(performance: performance),
                      ),
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
}
