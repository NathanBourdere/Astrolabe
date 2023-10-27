import 'package:festival/models/artiste.dart';
import 'package:festival/models/performance.dart';
import 'package:festival/performance.dart';
import 'package:flutter/material.dart';

class PageArtiste extends StatelessWidget {
  final Artiste artiste;
  final List<Performance> performances;

  const PageArtiste(
      {Key? key, required this.artiste, required this.performances})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(artiste.nomArtiste),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {
              // Navigate to the home page
              Navigator.pushNamed(context, '/');
            },
          ),
        ],
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
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: performances.length,
              itemBuilder: (context, index) {
                final performance = performances[index];
                return ListTile(
                  title: Text(performance.nomPerformance),
                  onTap: () {
                    Navigator.pushNamed(
                        context, '/performance/$performance.idPerformance',
                        arguments: performance.idPerformance);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
