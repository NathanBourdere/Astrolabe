import 'dart:io';

import 'package:festival/artiste_page.dart';
import 'package:festival/database.dart';
import 'package:festival/models/configuration.dart';
import 'package:flutter/material.dart';
import 'package:festival/models/artiste.dart';
import 'package:festival/models/performance.dart';

class LikedArtistsPage extends StatefulWidget {
  final Future<List<Artiste>> likedArtists;
  final Configuration configuration;
  final GlobalKey<LikedArtistsPageState> key;

  LikedArtistsPage({
    required this.likedArtists,
    required this.configuration,
    required this.key,
  }) : super(key: key);

  @override
  LikedArtistsPageState createState() => LikedArtistsPageState();
}

class LikedArtistsPageState extends State<LikedArtistsPage> {
  late Future<List<Artiste>> _likedArtists;

  Future<void> refresh() async {
    await Future.delayed(Duration(milliseconds: 100));
    setState(() {
      _likedArtists = DatabaseAstrolabe.instance.getLikedArtistes();
    });
  }

  @override
  void initState() {
    super.initState();
    _likedArtists = widget.likedArtists;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: refresh,
        child: FutureBuilder<List<Artiste>>(
          future: _likedArtists,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              List<Artiste> artists = snapshot.data!;

              return ListView.builder(
                itemCount: artists.length,
                itemBuilder: (context, index) {
                  Artiste artist = artists[index];
                  return GestureDetector(
                    onTap: () async {
                      List<Performance> performances = await DatabaseAstrolabe
                          .instance
                          .getPerformancesByArtiste(artist);
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PageArtiste(
                            artiste: artist,
                            performances: performances,
                            configuration: widget.configuration,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      color: widget.configuration.getBackgroundColor,
                      child: Column(
                        // change the color of the card depending on the index
                        children: [
                          CircleAvatar(
                            backgroundImage: FileImage(File(artist.image)),
                            radius: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              artist.nom,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
