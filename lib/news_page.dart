import 'package:flutter/material.dart';
import 'models/news.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

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
        corps: 'corps 1',
        image: 'Image 1',
        isRead: 0,
      ),
      News(
        idNews: 2,
        titre: 'Titre 2',
        corps: 'corps 2',
        image: 'Image 2',
        isRead: 0,
      ),
      News(
        idNews: 3,
        titre: 'Titre 3',
        corps: 'corps 3',
        image: 'Image 3',
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
// Indiquez si la notification a été lue

          // Déterminez la couleur en fonction de si la notification est lue ou non

          return ListTile(
            title: Text(
              notification.corps,
              style: const TextStyle(color: Colors.grey),
            ),
          );
        },
      )),
    );
  }
}
