// ignore_for_file: unused_import

import 'package:festival/database.dart';
import 'package:festival/models/configuration.dart';
import 'package:festival/models/performance.dart';
import 'package:festival/performance.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PerformancesTagPage extends StatelessWidget {
  final Configuration configuration;
  const PerformancesTagPage({Key? key, required this.configuration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    final tagId = arguments as int;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Performances'),
      ),
      body: FutureBuilder<List<Performance>>(
        future: DatabaseAstrolabe.instance.getPerformancesByTag(tagId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final performances = snapshot.data!;
            return ListView.builder(
              itemCount: performances.length,
              itemBuilder: (context, index) {
                final performance = performances[index];
                return ListTile(
                    title: Text(performance.nom,
                        style: GoogleFonts.getFont(
                            configuration.getpoliceEcriture,
                            textStyle: TextStyle(
                                fontSize: 16,
                                color: configuration.getFontColor))),
                    subtitle: Text(
                      '${performance.date} à ${performance.heure_debut} - ${performance.heure_fin}',
                      style: GoogleFonts.getFont(
                          configuration.getpoliceEcriture,
                          textStyle: TextStyle(
                              fontSize: 14, color: configuration.getFontColor)),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/performance/',
                          arguments: performance.id);
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
