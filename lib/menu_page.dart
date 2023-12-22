import 'dart:io';

import 'package:festival/database.dart';
import 'package:festival/models/configuration.dart';
import 'package:festival/models/performance.dart';
import 'package:festival/models/tag.dart'; // Import the Tag class
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PerformancesPage extends StatefulWidget {
  final Configuration configuration;
  const PerformancesPage({Key? key, required this.configuration})
      : super(key: key);

  @override
  _PerformancesPageState createState() => _PerformancesPageState();
}

class _PerformancesPageState extends State<PerformancesPage> {
  Tag? selectedTag; // Nullable Tag
  late Future<List<Tag>> tagsFuture;

  @override
  void initState() {
    super.initState();
    tagsFuture = DatabaseAstrolabe.instance.getTags();
  }

  Future<Widget> _buildPerformanceTile(
      BuildContext context, Performance performance) async {
    final imageURL = await DatabaseAstrolabe.instance
        .getArtistImageByPerformance(performance);
    return ListTile(
      leading: Image.file(
        File(imageURL),
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      ),
      title: Text(
        performance.nom,
        style: GoogleFonts.getFont(
          widget.configuration.getpoliceEcriture,
          textStyle: TextStyle(
            fontSize: 16,
            color: widget.configuration.getFontColor,
          ),
        ),
      ),
      subtitle: Text(
        '${performance.date} à ${performance.heure_debut} - ${performance.heure_fin}',
        style: GoogleFonts.getFont(
          widget.configuration.getpoliceEcriture,
          textStyle: TextStyle(
            fontSize: 14,
            color: widget.configuration.getFontColor,
          ),
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, '/performance/',
            arguments: performance.id);
      },
    );
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: FutureBuilder<List<Tag>>(
              future: tagsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return const Text('Error loading tags');
                } else {
                  final tags = snapshot.data!;
                  return DropdownButton<Tag>(
                    value: selectedTag,
                    items: tags.map((Tag value) {
                      return DropdownMenuItem<Tag>(
                        value: value,
                        child: Text(value.nom),
                      );
                    }).toList(),
                    onChanged: (Tag? newValue) {
                      setState(() {
                        selectedTag = newValue;
                      });
                    },
                  );
                }
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Performance>>(
              future: DatabaseAstrolabe.instance.getPerformancesByTag(selectedTag?.id ?? -1),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final performances = snapshot.data!;
                  return ListView.builder(
                    itemCount: performances.length,
                    itemBuilder: (context, index) {
                      final performance = performances[index];
                      return FutureBuilder<Widget>(
                        future: _buildPerformanceTile(context, performance),
                        builder: (context, tileSnapshot) {
                          if (tileSnapshot.hasData) {
                            return tileSnapshot.data!;
                          } else if (tileSnapshot.hasError) {
                            return Text('${tileSnapshot.error}');
                          }
                          return const CircularProgressIndicator();
                        },
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }
}