import 'dart:io';

import 'package:festival/performances.dart';
import 'package:festival/scenes_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'artistes_page.dart';
import 'models/configuration.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final configuration =
        Provider.of<ValueNotifier<Configuration>>(context).value;
    return Drawer(
      backgroundColor: configuration.getBackgroundColor,
      child: ListView(
        children: [
          DrawerHeader(
              child: Image.file(
            File(configuration.logoFestival),
            fit: BoxFit.cover,
          )),
          ListTile(
            title: Text(
              "Accueil",
              style: GoogleFonts.getFont(configuration.getpoliceEcriture,
                  textStyle: TextStyle(
                      fontSize: 16,
                      color: configuration.getFontColor,
                      fontWeight: FontWeight.bold)),
            ),
            onTap: () {
              Navigator.pop(context);
              if (ModalRoute.of(context)?.settings.name != '/') {
                Navigator.pushNamed(context, '/');
              }
            },
          ),
          ListTile(
            title: Text(
              "Artistes",
              style: GoogleFonts.getFont(configuration.getpoliceEcriture,
                  textStyle: TextStyle(
                      fontSize: 16,
                      color: configuration.getFontColor,
                      fontWeight: FontWeight.bold)),
            ),
            onTap: () {
              Navigator.pop(context);
              if (ModalRoute.of(context)?.settings.name != '/artistes') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ArtistesPage()),
                );
              }
            },
          ),
          ListTile(
            title: Text(
              "Calendrier",
              style: GoogleFonts.getFont(configuration.getpoliceEcriture,
                  textStyle: TextStyle(
                      fontSize: 16,
                      color: configuration.getFontColor,
                      fontWeight: FontWeight.bold)),
            ),
            onTap: () {
              Navigator.pop(context);
              if (ModalRoute.of(context)?.settings.name != '/calendrier') {
                Navigator.pushNamed(context, '/calendrier');
              }
            },
          ),
          ListTile(
            title: Text(
              "Billetterie",
              style: GoogleFonts.getFont(configuration.getpoliceEcriture,
                  textStyle: TextStyle(
                      fontSize: 16,
                      color: configuration.getFontColor,
                      fontWeight: FontWeight.bold)),
            ),
            onTap: () {
              Navigator.pop(context);
              if (ModalRoute.of(context)?.settings.name != '/billetterie') {
                Navigator.pushNamed(context, '/billetterie');
              }
            },
          ),
          ListTile(
            title: Text(
              "Performances",
              style: GoogleFonts.getFont(configuration.getpoliceEcriture,
                  textStyle: TextStyle(
                      fontSize: 16,
                      color: configuration.getFontColor,
                      fontWeight: FontWeight.bold)),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PerformancesPage()),
              );
            },
          ),
          ListTile(
            title: Text(
              "Scenes",
              style: GoogleFonts.getFont(configuration.getpoliceEcriture,
                  textStyle: TextStyle(
                      fontSize: 16,
                      color: configuration.getFontColor,
                      fontWeight: FontWeight.bold)),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ScenesPage()),
              );
            },
          )
        ],
      ),
    );
  }
}
