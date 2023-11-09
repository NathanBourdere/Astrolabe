import 'dart:io';

import 'package:festival/database.dart';
import 'package:festival/models/configuration.dart';
import 'package:festival/navbar.dart';
import 'package:festival/scene_page.dart';
import 'package:flutter/material.dart';
import 'package:festival/models/scene.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ScenesPage extends StatelessWidget {
  const ScenesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Configuration configuration =
        Provider.of<ValueNotifier<Configuration>>(context).value;
    return Scaffold(
        drawer: const NavBar(),
        appBar: AppBar(
          title: const Text('Scènes'),
        ),
        body: FutureBuilder<List<Scene>>(
          future: DatabaseAstrolabe.instance.getScenes(),
          builder: (BuildContext context, AsyncSnapshot<List<Scene>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final scene = snapshot.data![index];
                  return ListTile(
                    leading: Image.file(
                      File(scene.image),
                      fit: BoxFit.cover,
                    ),
                    title: Text(scene.nom,
                        style: GoogleFonts.getFont(
                            configuration.getpoliceEcriture,
                            textStyle: TextStyle(
                                fontSize: 16,
                                color: configuration.getFontColor))),
                    onTap: () async {
                      final performances = await DatabaseAstrolabe.instance
                          .getPerformancesByScene(scene);
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ScenePage(
                              scene: scene, performances: performances),
                        ),
                      );
                    },
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
