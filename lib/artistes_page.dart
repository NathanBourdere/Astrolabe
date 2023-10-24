import 'package:flutter/material.dart';

class ArtistesPage extends StatefulWidget {
  @override
  State<ArtistesPage> createState() => _ArtistesPageState();
}

class _ArtistesPageState extends State<ArtistesPage> {
  @override
  Widget build(BuildContext context) {
    // Construisez le contenu de la page "Artistes" ici
    return Scaffold(
      appBar: AppBar(
        title: Text('Artistes'),
      ),
      body: Center(
        child: Text('Contenu de la page "Artistes"'),
      ),
    );
  }
}
