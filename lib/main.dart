import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Geralt Profile Card',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF8B0000),
          secondary: Color(0xFFD4AF37),
        ),
        useMaterial3: true,
      ),
      home: const RowColumnPage(),
    );
  }
}

class RowColumnPage extends StatelessWidget {
  const RowColumnPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double screenWidth = mediaQueryData.size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Witcher Profile',
          style: TextStyle(
            color: Color(0xFFD4AF37),
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        backgroundColor: const Color(0xFF0A0A0A),
        centerTitle: true,
        elevation: 5,
        shadowColor: const Color(0xFF8B0000),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: AspectRatio(
                aspectRatio: 1.0,
                child: Container(
                  width: screenWidth,
                  margin: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 10.0),
                  padding: const EdgeInsets.all(20.0),
                  color: const Color(0xFF1E1E1E),
                  child: Center(
                    child: Image.asset(
                      'gambar/geralt-of-rivia-icon-the-witcher-3-wild-hunt-wiki-guide.png',
                      fit: BoxFit.cover,
                      width: 500,
                      errorBuilder: (context, error, stack) => const Icon(
                        Icons.person,
                        size: 100,
                        color: Color(0xFF555555),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: screenWidth,
              margin: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 10.0),
              padding: const EdgeInsets.all(20.0),
              color: const Color(0xFF292929),
              child: const Column(
                children: [
                  Text(
                      'Geralt of Rivia',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Monster Slayer, Witcher, and Swordsman\nBased in Kaer Morhen, The Continent.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFFAAAAAA),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Container(
              width: screenWidth,
              color: const Color(0xFF1E1E1E),
              padding: const EdgeInsets.all(20.0),
              margin: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 5.0),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(children: [
                    Icon(Icons.sports_martial_arts, color: Color(0xFFD4AF37)),
                    SizedBox(height: 4),
                    Text("Combat", style: TextStyle(color: Colors.white70))
                  ]),
                  Column(children: [
                    Icon(Icons.science, color: Color(0xFF8B0000)),
                    SizedBox(height: 4),
                    Text("Alchemy", style: TextStyle(color: Colors.white70))
                  ]),
                  Column(children: [
                    Icon(Icons.style, color: Color(0xFFD4AF37)),
                    SizedBox(height: 4),
                    Text("Gwent", style: TextStyle(color: Colors.white70))
                  ]),
                ],
              ),
            ),
            const CounterCard(),
          ],
        ),
      ),
    );
  }
}

class CounterCard extends StatefulWidget {
  const CounterCard({super.key});

  @override
  State<CounterCard> createState() => _CounterCardState();
}

class _CounterCardState extends State<CounterCard> {
  bool _isFollowed = false;
  int _counter = 1500;

  void _toggleFollow() {
    setState(() {
      _isFollowed = !_isFollowed;
      if (_isFollowed) {
        _counter++;
      } else {
        _counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 20.0),
      padding: const EdgeInsets.all(20.0),
      width: MediaQuery.of(context).size.width,
      color: const Color(0xFF292929),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
              "Followers: $_counter",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              )
          ),
          Container(
            color: _isFollowed ? const Color(0xFFD4AF37) : const Color(0xFF8B0000),
            padding: const EdgeInsets.all(5.0),
            child: IconButton(
              onPressed: _toggleFollow,
              icon: Icon(
                  _isFollowed ? Icons.check : Icons.person_add,
                  color: _isFollowed ? Colors.black : Colors.white,
                  size: 20
              ),
            ),
          ),
        ],
      ),
    );
  }
}
