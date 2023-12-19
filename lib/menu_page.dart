import 'package:festival/database.dart';
import 'package:festival/models/tag.dart';
import 'package:flutter/material.dart';
class MenuPage extends StatelessWidget {
  const MenuPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // First Row for Artistes, Scènes, Programmes
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/artistes');
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text('Artistes'),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/scenes');
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text('Scènes'),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/performances');
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text('Programmes'),
                ),
              ),
            ],
          ),
          const Divider(), // Divider between the first row and the future buttons
          // Future buttons generated by the future function
          Expanded(
            child: FutureBuilder<List<Tag>>(
              future: DatabaseAstrolabe.instance.getTags(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else {
                  List<Tag> tags = snapshot.data!;
                  return ListView.builder(
                    itemCount: tags.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(tags[index].nom),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/performances_tags',
                            arguments: tags[index].idTag,
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
