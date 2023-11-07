import 'package:festival/database.dart';
import 'package:festival/models/configuration.dart';
import 'package:festival/models/performance.dart';
import 'package:festival/navbar.dart';
import 'package:festival/performance.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PerformancesPage extends StatelessWidget {
  const PerformancesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Configuration configuration =
        Provider.of<ValueNotifier<Configuration>>(context).value;
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
                    title: Text(performance.nomPerformance,
                        style: GoogleFonts.getFont(
                            configuration.getPoliceEcriture,
                            textStyle: TextStyle(
                                fontSize: 16,
                                color: configuration.getFontColor))),
                    subtitle: Text(
                      '${performance.datePerformance} à ${performance.heureDebutPerformance} - ${performance.heureFinPerformance}',
                      style: GoogleFonts.getFont(
                          configuration.getPoliceEcriture,
                          textStyle: TextStyle(
                              fontSize: 14, color: configuration.getFontColor)),
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
