import 'dart:io';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:festival/database.dart';
import 'artiste_page.dart';
import 'models/artiste.dart';
import 'package:festival/models/performance.dart';


class CarouselSliderWidget extends StatelessWidget {
  const CarouselSliderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DatabaseAstrolabe database = DatabaseAstrolabe.instance;

    return FutureBuilder(
      future: database.getArtistes(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final artistes = snapshot.data as List<Artiste>;
          return CarouselSlider(
            items: artistes.asMap().entries.map((entry) {
              final index = entry.key;
              final artiste = entry.value;

              return GestureDetector(
                onTap: () async {
                  List<Performance> performances = await DatabaseAstrolabe.instance.getPerformancesByArtiste(artiste);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PageArtiste(
                        artiste: artiste,
                        performances: performances,
                      ),
                    ),
                  );
                },
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(File(artiste.image)),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              artiste.nom,
                              style: const TextStyle(
                                fontSize: 42,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 100,
                      right: 100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(4.0),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'DANS ${index + 1} JOURS',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height,
              aspectRatio: 16 / 9,
              viewportFraction: 1.0,
              initialPage: 0,
              enableInfiniteScroll: true,
              autoPlay: true,
              enlargeCenterPage: true,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
