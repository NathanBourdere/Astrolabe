import 'package:festival/database.dart';
import 'package:festival/navbar.dart';
import 'package:festival/scene_page.dart';
import 'package:flutter/material.dart';
import 'package:festival/models/scene.dart';

class ScenesPage extends StatelessWidget {
  const ScenesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    title: Text(scene.nomScene),
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
