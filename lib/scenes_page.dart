import 'package:festival/database.dart';
import 'package:festival/models/configuration.dart';
// ignore: unused_import
import 'package:festival/scene_page.dart';
import 'package:flutter/material.dart';
import 'package:festival/models/scene.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';

class ScenesPage extends StatelessWidget {
  final Configuration configuration;
  const ScenesPage({Key? key, required this.configuration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              scene: scene, performances: performances, configuration: configuration),
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
