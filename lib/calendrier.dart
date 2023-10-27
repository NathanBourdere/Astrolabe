import 'package:festival/navbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  // Liste des événements
  List<Event> events = [];

  // Date sélectionnée
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    // Ajout d'un événement par défaut
    events.add(Event(
        title: "Rendez-vous",
        start: DateTime(2023, 10, 25, 10, 0),
        end: DateTime(2023, 10, 25, 12, 0)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        title: const Text('Calendrier Programmable'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
              focusedDay: selectedDate,
              firstDay: DateTime(1990),
              lastDay: DateTime(2050),
              // Add an effect to the date selected to indicate it's been selected
              selectedDayPredicate: (day) {
                return isSameDay(selectedDate, day);
              },
              onDaySelected: (date, events) {
                // Mettre à jour la date sélectionnée
                setState(() {
                  selectedDate = date;
                });
              },
              eventLoader: (date) {
                // Vérifier s'il y a des événements pour la date donnée
                if (events
                    .where((event) =>
                        event.start.year == date.year &&
                        event.start.month == date.month &&
                        event.start.day == date.day)
                    .isNotEmpty) {
                  // Retourner un widget de point rouge
                  return [
                    Container(
                      constraints: const BoxConstraints(
                        minWidth: 10,
                        minHeight: 10,
                        maxWidth: 10,
                        maxHeight: 10,
                      ),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                    ),
                  ];
                } else {
                  // Retourner une liste vide
                  return [];
                }
              },
            ),
            // Afficher les événements pour la date sélectionnée
            ListView.builder(
              shrinkWrap: true,
              itemCount: getEventsForDate(selectedDate).length,
              itemBuilder: (context, index) {
                Event event = getEventsForDate(selectedDate)[index];
                return Container(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      // Date de l'événement
                      Text(
                        DateFormat("dd/MM/yyyy").format(event.start),
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(width: 8),
                      // Titre de l'événement
                      Text(event.title),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Fonction pour récupérer les événements pour une date donnée
  List<Event> getEventsForDate(DateTime date) {
    return events
        .where((event) =>
            event.start.year == date.year &&
            event.start.month == date.month &&
            event.start.day == date.day)
        .toList();
  }
}

class Event {
  // Titre de l'événement
  String title;

  // Date de début de l'événement
  DateTime start;

  // Date de fin de l'événement
  DateTime end;

  // Constructeur
  Event({
    required this.title,
    required this.start,
    required this.end,
  });
}
