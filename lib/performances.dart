import 'package:festival/database.dart';
import 'package:festival/models/performance.dart';
import 'package:festival/navbar.dart';
import 'package:festival/performance.dart';
import 'package:flutter/material.dart';

class PerformancesPage extends StatelessWidget {
  const PerformancesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        title: const Text('Performances'),
      ),
      body: FutureBuilder<List<Performance>>(
        future: DatabaseAstrolabe.instance.getPerformances(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final performances = snapshot.data!;
            return ListView.builder(
              itemCount: performances.length,
              itemBuilder: (context, index) {
                final performance = performances[index];
                return ListTile(
                    title: Text(performance.nomPerformance),
                    subtitle: Text(
                      '${performance.datePerformance} à ${performance.heureDebutPerformance} - ${performance.heureFinPerformance}',
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/performance/',
                          arguments: performance.idPerformance);
                    });
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
