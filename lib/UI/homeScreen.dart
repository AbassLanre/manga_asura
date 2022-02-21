import 'package:flutter/material.dart';
import 'package:manga_asura/constants/constants.dart';
import 'package:web_scraper/web_scraper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedNavBar = 0;
  List<Map<String, dynamic>> mangaList = [];
  bool mangaLoaded = false;

  onTapNavBar(int index) {
    setState(() {
      selectedNavBar = index;
    });
  }

  fetchAsuraManga() async {
    final webScraper = WebScraper(kBaseUrl);

      if (await webScraper.loadWebPage('/manga/?status=&type=&order=popular')) {
        mangaList = webScraper.getElement(
            'div.wrapper > div.postbody > div.bixbox > div.mrgn > div.listupd > div.bs > div.bsx > a > div.limit > img',
            ['src']);
        mangaLoaded = true;
        print(mangaList);
      }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAsuraManga();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mangaLoaded
          ? const Center(
              child: Text('Home Here'),
            )
          : const Center(child: CircularProgressIndicator()),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: kColor1,
        selectedItemColor: kColor3,
        unselectedItemColor: Colors.white,
        currentIndex: selectedNavBar,
        onTap: onTapNavBar,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.explore_outlined), label: 'Discover'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorite'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Recent'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ],
      ),
    );
  }
}
