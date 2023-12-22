import 'dart:io';

import 'package:festival/database.dart';
import 'package:festival/models/news.dart';
import 'package:flutter/material.dart';


class NewsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actualités'),
      ),
      body: FutureBuilder<List<News>>(
        // Utilisez votre fonction getNews ici
        future: DatabaseAstrolabe.instance.getNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erreur: ${snapshot.error}'),
            );
          } else {
            // La liste de News récupérée
            List<News> newsList = snapshot.data!;

            // Construisez la liste d'éléments ici
            return ListView.builder(
              itemCount: newsList.length,
              itemBuilder: (context, index) {
                News news = newsList[index];

                // Vous pouvez personnaliser cela en fonction de vos besoins
                return ListTile(
                  title: Text(news.titre),
                  subtitle: Text(news.corps),
                  leading: news.image != ''
                      ? Image.file(
                          File(news.image),
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                      : null,
                );
              },
            );
          }
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: NewsPage(),
  ));
}
