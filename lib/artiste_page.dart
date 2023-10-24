import 'package:festival/models/artiste.dart';
import 'package:flutter/material.dart';

class PageArtiste extends StatelessWidget {
  final Artiste artiste;

  const PageArtiste({Key? key, required this.artiste}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(artiste.nomArtiste),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(artiste.imageArtiste),
            Text(
              artiste.nomArtiste,
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              artiste.descriptionArtiste,
              style: const TextStyle(fontSize: 16),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.link),
                  tooltip: 'Site web',
                ),
                Text(artiste.siteWebArtiste),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.video_library),
                  tooltip: 'YouTube',
                ),
                Text(artiste.youtubeArtiste),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.person),
                  tooltip: 'Instagram',
                ),
                Text(artiste.instagramArtiste),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.facebook),
                  tooltip: 'Facebook',
                ),
                Text(artiste.facebookArtiste),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
