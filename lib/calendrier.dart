// ignore_for_file: unused_import, non_constant_identifier_names

import 'package:festival/database.dart';
import 'package:festival/models/configuration.dart';
import 'package:festival/models/performance.dart';
import 'package:festival/navbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  // Liste des performances
  List<Performance> performances = [];
  List<Event> events = [];
  DateTime selectedDate = DateTime.now();
  DatabaseAstrolabe database = DatabaseAstrolabe.instance;

  @override
  void initState() {
    super.initState();

    // Fetch performances from the database once
    _fetchPerformances();
  }

  Future<List<Event>> _fetchPerformances() async {
    // Get performances from the database
    performances = await database.getPerformances();

    // Convert performances to events
    events = performances
        .map((performance) => Event(
            titre: performance.nom,
            date: DateTime.parse(performance.date),
            heure_debut: TimeOfDay(
                hour: int.parse(performance.heure_debut.split(":")[0]),
                minute: int.parse(performance.heure_debut.split(":")[1])),
            heure_fin: TimeOfDay(
                hour: int.parse(performance.heure_fin.split(":")[0]),
                minute: int.parse(performance.heure_fin.split(":")[1]))))
        .toList();

    return events;
  }

  @override
  Widget build(BuildContext context) {
    final configuration =
        Provider.of<ValueNotifier<Configuration>>(context).value;
    return Scaffold(
      body: FutureBuilder(
        future: _fetchPerformances(), // Async data
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TableCalendar(
                    // Changer la couleur
                    calendarStyle: CalendarStyle(
                      defaultTextStyle:
                          TextStyle(color: configuration.getMainColor),
                    ),
                    focusedDay: selectedDate,
                    firstDay: DateTime(2023),
                    lastDay: DateTime(2050),
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
                      // Vérifier s'il y a des performances pour la date donnée
                      if (events
                          .where((event) =>
                              event.date.year == date.year &&
                              event.date.month == date.month &&
                              event.date.day == date.day)
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
                  // Afficher les performances pour la date sélectionnée
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: getEventsForDate(selectedDate).length,
                    itemBuilder: (context, index) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: getEventsForDate(selectedDate).length,
                        itemBuilder: (context, index) {
                          Event event = getEventsForDate(selectedDate)[index];
                          // Create a list of widgets for each performance
                          List<Widget> performanceWidgets =
                              performances.map((performance) {
                            return ListTile(
                              title: Text(
                                "${event.titre} - ${DateFormat("dd/MM/yyyy").format(event.date)}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: configuration.getFontColor,
                                ),
                              ),
                              subtitle: Text(
                                "${event.heure_debut.hour}:${event.heure_debut.minute} - ${event.heure_fin.hour}:${event.heure_fin.minute}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: configuration.getFontColor,
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
                          }).toList();

                          // Return the list of performance widgets
                          return Column(
                            children: performanceWidgets,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  // Fonction pour récupérer les événements pour une date donnée
  List<Event> getEventsForDate(DateTime date) {
    return events
        .where((event) =>
            event.date.year == date.year &&
            event.date.month == date.month &&
            event.date.day == date.day)
        .toList();
  }
}

class Event {
  // Titre de l'événement
  String titre;

  // Date de début de l'événement
  DateTime date;

  // Heure de début de l'événement
  TimeOfDay heure_debut;

  // Heure de fin de l'événement
  TimeOfDay heure_fin;

  // Constructeur
  Event({
    required this.titre,
    required this.date,
    required this.heure_debut,
    required this.heure_fin,
  });
}
