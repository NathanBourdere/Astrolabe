import 'package:festival/artistes_page.dart';
import 'package:festival/database.dart';
import 'package:festival/like_page.dart';
import 'package:festival/models/configuration.dart';
import 'package:flutter/material.dart';
import 'billetterie_page.dart';
import 'carousel.dart';
import 'menu_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyHomePage extends StatefulWidget {
  final Configuration configuration;
  const MyHomePage(
      {super.key, required this.title, required this.configuration});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    // Initialize _pages here
    _pages = [
      CarouselSliderWidget(configuration: widget.configuration),
      const BilletteriePage(),
      LikedArtistsPage(
        key: GlobalKey<LikedArtistsPageState>(),
        likedArtists: DatabaseAstrolabe.instance.getLikedArtistes(),
        configuration: widget.configuration,
      ),
      ArtistesPage(configuration: widget.configuration),
      PerformancesPage(
        configuration: widget.configuration,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
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
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/informations');
          },
          icon: const Icon(Icons.info),
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: widget.configuration.getBackgroundColor,
        selectedItemColor: widget.configuration.getMainColor,
        unselectedItemColor: widget.configuration.getFontColor,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.house),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.ticketSimple),
            label: 'Billeterie',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.heart),
            label: 'Likes',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.artstation),
            label: 'Artistes',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.bars),
            label: 'Menu',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            bottom: 16.0), // Ajustez la valeur selon vos besoins
        child: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
      ),
    );
  }
}
