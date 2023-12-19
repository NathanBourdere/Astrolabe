import 'dart:io';

import 'package:festival/models/partenaire.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:festival/database.dart';
import 'package:festival/models/configuration.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class InformationsPage extends StatefulWidget {
  const InformationsPage({Key? key});

  @override
  _InformationsPageState createState() => _InformationsPageState();
}

class _InformationsPageState extends State<InformationsPage> {
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();

    // Video player controller
    VideoPlayerController _controller = VideoPlayerController.network(
      'https://cdn.discordapp.com/attachments/1154325887693619201/1186658033485488138/Chipi_chipi_chapa_chapa_cat.mp4?ex=65940c6a&is=6581976a&hm=47359f229c8a598856a54a99e103c1087e18617e5b67a2c94bca29d3c5515ff4&',
    );

    // Chewie controller
    _chewieController = ChewieController(
      videoPlayerController: _controller,
      autoPlay: false,
      looping: true, // Set to true if you want the video to loop
    );
  }

  @override
  void dispose() {
    // Dispose of the chewieController when the page is disposed
    _chewieController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Configuration configuration =
        Provider.of<ValueNotifier<Configuration>>(context).value;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Informations'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Display Festival Name
          Text(
            configuration.nomFestival,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          // DIsplay festival description
          Text(
            configuration.descriptionFestival,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          // Display Festival Partners
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Partenaires',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              // Display Partner Logos
              FutureBuilder<List<Partenaire>>(
                future: DatabaseAstrolabe.instance.getPartenaires(),
                builder: (context, partenairesSnapshot) {
                  if (partenairesSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (partenairesSnapshot.hasError) {
                    return Text(
                        'Error loading partners: ${partenairesSnapshot.error}');
                  } else {
                    List<Partenaire> partenaires = partenairesSnapshot.data!;
                    return Container(
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              for (var partenaire in partenaires)
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  child: Image.file(File(partenaire.banniere)),
                                ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Display Links to Social Media
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Réseaux Sociaux',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              // Display Social Media Links
              Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const FaIcon(FontAwesomeIcons.facebook),
                          onPressed: () {
                            Uri url = Uri.parse(configuration.facebookFestival);
                            launchUrl(url);
                          },
                        ),
                        IconButton(
                          icon: const FaIcon(FontAwesomeIcons.youtube),
                          onPressed: () {
                            Uri url = Uri.parse(configuration.youtubeFestival);
                            launchUrl(url);
                          },
                        ),
                        IconButton(
                          icon: const FaIcon(FontAwesomeIcons.instagram),
                          onPressed: () {
                            Uri url =
                                Uri.parse(configuration.instagramFestival);
                            launchUrl(url);
                          },
                        ),
                        IconButton(
                          icon: const FaIcon(FontAwesomeIcons.internetExplorer),
                          onPressed: () {
                            Uri url = Uri.parse(configuration.siteWebFestival);
                            launchUrl(url);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Vidéo promotionnelle',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              // Display Video
              Container(
                height: 300, // Set a fixed height or adjust as needed
                child: Chewie(controller: _chewieController),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
