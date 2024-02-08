import 'package:flutter/material.dart';
import 'package:festival/database.dart';
import 'package:festival/models/artiste.dart';
import 'package:festival/models/configuration.dart';
import 'package:festival/models/performance.dart';
import 'package:festival/artiste_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';

class ArtistesPage extends StatefulWidget {
  final Configuration configuration;

  const ArtistesPage({Key? key, required this.configuration}) : super(key: key);

  @override
  _ArtistesPageState createState() => _ArtistesPageState();
}

class _ArtistesPageState extends State<ArtistesPage> {
  late Future<List<Artiste>> _artistesFuture;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _artistesFuture = DatabaseAstrolabe.instance.getArtistes();
    _searchController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              style: GoogleFonts.getFont(
                widget.configuration.getpoliceEcriture,
                textStyle: TextStyle(
                  color: widget.configuration.getFontColor,
                ),
              ),
              cursorColor: widget.configuration.getFontColor,
              onChanged: (value) {
                setState(() {
                  // Recharge la liste des artistes en fonction du texte de recherche
                  _artistesFuture = DatabaseAstrolabe.instance.searchArtistes(value);
                });
              },
              decoration: InputDecoration(
                hintText: 'Rechercher un artiste...',
                prefixIcon: Icon(Icons.search, color: widget.configuration.getFontColor),
                hintStyle: GoogleFonts.getFont(
                  widget.configuration.getpoliceEcriture,
                  textStyle: TextStyle(
                    color: widget.configuration.getFontColor,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: widget.configuration.getFontColor),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Artiste>>(
              future: _artistesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final artistes = snapshot.data ?? [];

                  if (artistes.isEmpty) {
                    return Center(
                      child: Text(
                        'Pas de résultat',
                        style: TextStyle(
                          fontSize: 18,
                          color: widget.configuration.getFontColor,
                          // Vous pouvez ajuster le style du texte selon vos préférences
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: artistes.length,
                    itemBuilder: (context, index) {
                      final artiste = artistes[index];
                      return GestureDetector(
                        onTap: () async {
                          List<Performance> performances =
                          await DatabaseAstrolabe.instance.getPerformancesByArtiste(artiste);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PageArtiste(
                                artiste: artiste,
                                performances: performances,
                                configuration: widget.configuration,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 0,
                          color: widget.configuration.getMainColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: FileImage(File(artiste.image)),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    artiste.nom,
                                    style: GoogleFonts.getFont(
                                      widget.configuration.getpoliceEcriture,
                                      textStyle: TextStyle(
                                        fontSize: 18,
                                        color: widget.configuration.getFontColor,
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    artiste.like == 1 ? Icons.favorite : Icons.favorite_border,
                                    color: artiste.like == 1 ? Colors.red : null,
                                  ),
                                  onPressed: () {
                                    int newLikeStatus = artiste.like == 1 ? 0 : 1;
                                    DatabaseAstrolabe.instance.setLike(artiste, newLikeStatus);
                                    setState(() {
                                      artiste.like = newLikeStatus;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
