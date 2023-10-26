import 'package:flutter/material.dart';
import 'models/news.dart';

class NewsPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    List<News> notifications = [
      News(
        idNews: 1,
        titre: 'Titre 1',
        texte: 'Texte 1',
        imageNews: 'Image 1',
        isRead: 0,
      ),
      News(
        idNews: 2,
        titre: 'Titre 2',
        texte: 'Texte 2',
        imageNews: 'Image 2',
        isRead: 0,
      ),
      News(
        idNews: 3,
        titre: 'Titre 3',
        texte: 'Texte 3',
        imageNews: 'Image 3',
        isRead: 0,
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Center(
          // Vous afficherez les notifications ici
          child: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          final isRead =
              notification.isRead; // Indiquez si la notification a été lue

          // Déterminez la couleur en fonction de si la notification est lue ou non

          return ListTile(
            title: Text(
              notification.texte,
              style: TextStyle(color: Colors.grey),
            ),
          );
        },
      )),
    );
  }
}
