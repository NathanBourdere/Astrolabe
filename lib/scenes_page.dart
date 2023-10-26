import 'package:festival/database.dart';
import 'package:festival/main.dart';
import 'package:festival/models/performance.dart';
import 'package:festival/navbar.dart';
import 'package:festival/scene_page.dart';
import 'package:flutter/material.dart';
import 'package:festival/models/scene.dart';

class ScenesPage extends StatelessWidget {
  final List<Scene> scenes;

  const ScenesPage({Key? key, required this.scenes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        title: const Text('Scènes'),
      ),
      body: ListView.builder(
        itemCount: scenes.length,
        itemBuilder: (context, index) {
          final scene = scenes[index];
          return ListTile(
            title: Text(scene.nomScene),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScenePage(
                      scene: scene,
                      performances: DatabaseAstrolabe.instance
                          .getPerformancesByScene(scene)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
