import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/configuration.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final configuration =
        Provider.of<ValueNotifier<Configuration>>(context).value;

    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            color: configuration.getMainColor, // Couleur principale
            borderRadius: BorderRadius.circular(12.0), // Arrondir les coins
          ),
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                title: const Text('Artistes'),
                onTap: () {
                  Navigator.pushNamed(context, '/artistes');
                },
              ),
              const Divider(), // Ajoute une ligne de séparation
              ListTile(
                title: const Text('Scènes'),
                onTap: () {
                  Navigator.pushNamed(context, '/scenes');
                },
              ),
              const Divider(), // Ajoute une ligne de séparation
              ListTile(
                title: const Text('Programmes'),
                onTap: () {
                  Navigator.pushNamed(context, '/performances');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
