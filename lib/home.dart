import 'package:flutter/material.dart';
import 'models/artiste.dart';
import 'navbar.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLiked = false; // État local pour suivre le clic sur l'icône

  List<Artiste> artistes = [
    Artiste(
      idArtiste: 1,
      nomArtiste: "Daft Punk",
      descriptionArtiste: "Daft Punk",
      siteWebArtiste: "https://www.daftpunk.com/",
      youtubeArtiste: "https://www.youtube.com/channel/UC_kRDKYrUlrbtrSiyu5Tflg",
      instagramArtiste: "https://www.instagram.com/daftpunk/",
      facebookArtiste: "https://www.facebook.com/daftpunk",
      imageArtiste: "daftpunk",
    ),
    Artiste(
      idArtiste: 2,
      nomArtiste: "Phantom Liberty",
      descriptionArtiste: "Phantom Liberty",
      siteWebArtiste: "",
      youtubeArtiste: "",
      instagramArtiste: "",
      facebookArtiste: "",
      imageArtiste: "phantomliberty",
    ),
    Artiste(
      idArtiste: 3,
      nomArtiste: "Hatsune Miku",
      descriptionArtiste: "Hatsune Miku",
      siteWebArtiste: "",
      youtubeArtiste: "",
      instagramArtiste: "",
      facebookArtiste: "",
      imageArtiste: "hatsunemiku",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: const Center(
          child: Text(
            "Astrolabe",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/news');
            },
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),

      body: CarouselSlider(
        items: artistes.map((artiste) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.8,  // Ajustez cette valeur pour déterminer la proportion de l'espace qu'occupe l'image
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/${artiste.imageArtiste}.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isLiked = !isLiked;
                    });
                  },
                  icon: Icon(
                    isLiked ? Icons.favorite : Icons.favorite_border,
                    color: isLiked ? Colors.red : Colors.black,
                  ),
                  color: Colors.white,
                  iconSize: 32.0,
                ),
              ],
            ),
          );
        }).toList(),
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height,
          aspectRatio: 16/9,
          viewportFraction: 1.0,  // Ajustez cette valeur pour qu'il prenne toute la largeur
          initialPage: 0,
          enableInfiniteScroll: true,
          autoPlay: false,
          enlargeCenterPage: true,
        ),
      )
    );
  }
}
