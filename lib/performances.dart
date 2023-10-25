import 'package:festival/models/performance.dart';
import 'package:festival/navbar.dart';
import 'package:festival/performance.dart';
import 'package:festival/tests.dart';
import 'package:flutter/material.dart';

class PerformancesPage extends StatelessWidget {
  final List<Performance> performances;

  const PerformancesPage({Key? key, required this.performances})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        title: const Text('Performances'),
      ),
      body: ListView.builder(
        itemCount: performances.length,
        itemBuilder: (context, index) {
          final performance = performances[index];
          return ListTile(
            title: Text(performance.nomPerformance),
            subtitle: Text(
              '${performance.datePerformance} à ${performance.heureDebutPerformance} - ${performance.heureFinPerformance}',
            ),
            onTap: () {
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
    );
  }
}
