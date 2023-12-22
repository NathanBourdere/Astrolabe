import 'dart:io';
import 'package:festival/models/artiste.dart';
import 'package:festival/models/configuration.dart';
import 'package:festival/models/performance.dart';
import 'package:flutter/material.dart';
import 'package:festival/database.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class PageArtiste extends StatefulWidget {
  final Artiste artiste;
  final List<Performance> performances;
  final Configuration configuration;

  const PageArtiste({
    Key? key,
    required this.artiste,
    required this.performances,
    required this.configuration,
  }) : super(key: key);

  @override
  _PageArtisteState createState() => _PageArtisteState();
}

class _PageArtisteState extends State<PageArtiste> {
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    // Set the initial like status based on artist's like property
    isLiked = widget.artiste.like == 1;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Performance>>(
      future:
          DatabaseAstrolabe.instance.getPerformancesByArtiste(widget.artiste),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          final performancesArtiste = snapshot.data!;

          return FutureBuilder<List<Artiste>>(
            future: DatabaseAstrolabe.instance.getArtistesRecos(widget.artiste),
            builder: (context, recommendedArtistsSnapshot) {
              if (recommendedArtistsSnapshot.connectionState ==
                  ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (recommendedArtistsSnapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text('Error: ${recommendedArtistsSnapshot.error}'),
                  ),
                );
              } else {
                final similarArtists = recommendedArtistsSnapshot.data!;

                return Scaffold(
                  body: CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        expandedHeight: 250,
                        backgroundColor: Colors.transparent,
                        flexibleSpace: Stack(
                          children: [
                            Positioned.fill(
                              child: Image.file(
                                File(widget.artiste.image),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    widget.configuration.getBackgroundColor,
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              left: 10,
                              child: Text(
                                widget.artiste.nom,
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Prochaines performances :",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: widget.configuration.getMainColor,
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: performancesArtiste.length,
                                itemBuilder: (context, index) {
                                  final performance =
                                      performancesArtiste[index];
                                  return ListTile(
                                    title: Text(performance.nom),
                                    subtitle: Text(
                                      '${performance.date} à ${performance.heure_debut} - ${performance.heure_fin}',
                                      style: GoogleFonts.getFont(
                                        widget.configuration.getpoliceEcriture,
                                        textStyle: TextStyle(
                                          fontSize: 14,
                                          color:
                                              widget.configuration.getFontColor,
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/performance/',
                                        arguments: performance.id,
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "A propos :",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: widget.configuration.getMainColor,
                                  ),
                                ),
                              ),
                              Text(
                                widget.artiste.description,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: widget.configuration.getMainColor,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Réseaux sociaux :",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: widget.configuration.getMainColor,
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      isLiked
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: isLiked ? Colors.red : null,
                                    ),
                                    onPressed: () {
                                      // Toggle the like status when the button is pressed
                                      toggleLikeStatus();
                                    },
                                  ),
                                  IconButton(
                                    icon:
                                        const FaIcon(FontAwesomeIcons.facebook),
                                    onPressed: () {
                                      Uri url =
                                          Uri.parse(widget.artiste.facebook);
                                      launchUrl(url);
                                    },
                                  ),
                                  IconButton(
                                    icon:
                                        const FaIcon(FontAwesomeIcons.youtube),
                                    onPressed: () {
                                      Uri url =
                                          Uri.parse(widget.artiste.youtube);
                                      launchUrl(url);
                                    },
                                  ),
                                  IconButton(
                                    icon: const FaIcon(
                                        FontAwesomeIcons.instagram),
                                    onPressed: () {
                                      Uri url =
                                          Uri.parse(widget.artiste.instagram);
                                      launchUrl(url);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Artistes similaires :",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: widget.configuration.getMainColor,
                                ),
                              ),
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 8.0,
                                  crossAxisSpacing: 8.0,
                                ),
                                itemCount: similarArtists.length,
                                itemBuilder: (context, index) {
                                  final similarArtist = similarArtists[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PageArtiste(
                                            artiste: similarArtist,
                                            performances: widget.performances,
                                            configuration: widget.configuration,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                          image: FileImage(
                                              File(similarArtist.image)),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          similarArtist.nom,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          );
        }
      },
    );
  }

  void toggleLikeStatus() {
    // Toggle the like status
    setState(() {
      isLiked = !isLiked;

      // Update the like status in the database
      int newLikeStatus = isLiked ? 1 : 0;
      widget.artiste.like = newLikeStatus;
      DatabaseAstrolabe.instance.setLike(widget.artiste, newLikeStatus);
    });
  }
}
