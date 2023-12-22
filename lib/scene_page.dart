// ignore_for_file: unused_import

import 'dart:io';

import 'package:festival/models/configuration.dart';
import 'package:festival/performance.dart';
import 'package:flutter/material.dart';
import 'package:festival/models/performance.dart';
import 'package:festival/models/scene.dart';
import 'package:google_fonts/google_fonts.dart';

class ScenePage extends StatelessWidget {
  final Scene scene;
  final List<Performance> performances;
  final Configuration configuration;

  const ScenePage(
      {Key? key,
      required this.scene,
      required this.performances,
      required this.configuration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(scene.nom), actions: [
        IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            // Navigate to the home page
            Navigator.pushNamed(context, '/');
          },
        ),
      ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Add the container with image and text
            Stack(
              children: [
                Image.file(
                  File(scene.image),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    color: Colors.black.withOpacity(0.5),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        scene.nom,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // The rest of the page content
            Text(
              'Événements :',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: configuration.getMainColor),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: performances.length,
              itemBuilder: (context, index) {
                final performance = performances[index];
                return ListTile(
                  title: Text(performance.nom,
                      style: TextStyle(
                          fontSize: 14, color: configuration.getFontColor)),
                  subtitle: Text(
                    '${performance.date} à ${performance.heure_debut} - ${performance.heure_fin}',
                    style: GoogleFonts.getFont(configuration.getpoliceEcriture,
                        textStyle: TextStyle(
                            fontSize: 14, color: configuration.getFontColor)),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/performance/',
                        arguments: performance.id);
                  },

                  // ...
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
