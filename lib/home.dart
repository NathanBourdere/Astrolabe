import 'package:festival/models/configuration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'billetterie_page.dart';
import 'carousel.dart';
import 'menu_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const CarouselSliderWidget(),
    const BilletteriePage(),
    const Center(child: Text('Likes')),
    const MenuPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final configuration =
        Provider.of<ValueNotifier<Configuration>>(context).value;

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
        backgroundColor: configuration.getBackgroundColor,
        selectedItemColor: configuration.getMainColor,
        unselectedItemColor: configuration.getFontColor,
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
