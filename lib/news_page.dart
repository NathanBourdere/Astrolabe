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
      News(1, "Nouvelle notification 1", "Ceci est la première notification", "image1.png"),
      News(2, "Nouvelle notification 2", "Ceci est la deuxième notification", "image2.png"),
      News(3, "Nouvelle notification 3", "Ceci est la troisième notification", "image3.png"),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: Center(
        // Vous afficherez les notifications ici
        child: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification = notifications[index];
            final isRead = notification.isRead; // Indiquez si la notification a été lue

            // Déterminez la couleur en fonction de si la notification est lue ou non
            final textColor = isRead ? Colors.grey : Colors.black;

            return ListTile(
              title: Text(
                notification.texte,
                style: TextStyle(color: textColor),
              ),
            );
          },
        )

      ),
    );
  }
}
