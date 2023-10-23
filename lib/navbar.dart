import 'package:flutter/material.dart';
import 'artiste_page.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Image.asset(
              "assets/images/image_festival.png",
              fit: BoxFit.contain,
            ),
          ),
          ListTile(
            title: const Text("Accueil"),
            onTap: () {
              // vérifie avant si on est déjà sur la page d'accueil, si oui on referme le menu
              if (ModalRoute.of(context)?.settings.name != '/') {
                Navigator.pushNamed(context, '/');
              } else {
                Navigator.pop(context);
              }
            },
          ),
          ListTile(
            title: const Text("Artistes"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ArtistesPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
