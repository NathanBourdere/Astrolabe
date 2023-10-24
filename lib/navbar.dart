import 'package:festival/calendrier.dart';
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
              // vérifie avant si on est déjà sur la page d'accueil, si oui on referme le menu
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ArtistesPage()),
              );
            },
          ),
          ListTile(
            title: const Text(
              "Calendrier",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CalendarPage()));
            },
          ),
        ],
      ),
    );
  }
}
