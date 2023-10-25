import 'package:festival/calendrier.dart';
import 'package:festival/performances.dart';
import 'package:festival/scenes_page.dart';
import 'package:festival/tests.dart';
import 'package:flutter/material.dart';
import 'artistes_page.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset(
              "assets/images/image_festival.png",
              fit: BoxFit.contain,
            ),
          ),
          ListTile(
            title: const Text(
              "Accueil",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              if (ModalRoute.of(context)?.settings.name != '/') {
                Navigator.pushNamed(context, '/');
              } else {
                Navigator.pop(context);
              }
            },
          ),
          ListTile(
            title: const Text(
              "Artistes",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              if (ModalRoute.of(context)?.settings.name != '/artistes') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ArtistesPage(
                            artistes: getTestArtistes(),
                          )),
                );
              } else {
                Navigator.pop(context);
              }
            },
          ),
          ListTile(
            title: const Text(
              "Calendrier",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              if (ModalRoute.of(context)?.settings.name != '/calendrier') {
                Navigator.pushNamed(context, '/calendrier');
              } else {
                Navigator.pop(context);
              }
            },
          ),
          ListTile(
            title: const Text(
              "Billetterie",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              if (ModalRoute.of(context)?.settings.name != '/billetterie') {
                Navigator.pushNamed(context, '/billetterie');
              } else {
                Navigator.pop(context);
              }
            },
          ),
          ListTile(
            title: const Text(
              "Performances",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PerformancesPage(
                          performances: getPerformancesTest(),
                        )),
              );
            },
          ),
          ListTile(
            title: const Text(
              "Scenes",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ScenesPage(
                          scenes: getTestScenes(),
                        )),
              );
            },
          )
        ],
      ),
    );
  }
}
