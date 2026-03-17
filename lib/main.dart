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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isFollowed = false;
  int _counter = 1500; // Counter awal untuk Geralt

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
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        centerTitle: true,
        title: const Text(
          'Witcher Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: ProfileCard(
          isFollowed: _isFollowed,
          counter: _counter,
          onFollowToggle: _toggleFollow,
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final bool isFollowed;
  final int counter;
  final VoidCallback onFollowToggle;

  const ProfileCard({
    super.key,
    required this.isFollowed,
    required this.counter,
    required this.onFollowToggle,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.85,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.indigo, width: 3),
              ),
              child: ClipOval(
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Image.asset(
                    'gambar/geralt-of-rivia-icon-the-witcher-3-wild-hunt-wiki-guide.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stack) => const Icon(
                      Icons.person,
                      size: 80,
                      color: Colors.indigo,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Geralt of Rivia',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Monster Slayer, Witcher, and Swordsman\nBased in Kaer Morhen, The Continent.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),
            const Divider(height: 1, color: Color(0xFFE0E0E0)),
            const SizedBox(height: 20),
            // Hobby Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                _HobbyIcon(icon: Icons.sports_martial_arts, label: 'Combat'),
                SizedBox(width: 20),
                _HobbyIcon(icon: Icons.science, label: 'Alchemy'),
                SizedBox(width: 20),
                _HobbyIcon(icon: Icons.style, label: 'Gwent'),
              ],
            ),
            const SizedBox(height: 24),
            // ── Counter Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.indigo.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.people, color: Colors.indigo, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Followers: $counter',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: onFollowToggle,
              icon: Icon(isFollowed ? Icons.check : Icons.person_add, size: 18),
              label: Text(isFollowed ? 'Following' : 'Follow'),
              style: ElevatedButton.styleFrom(
                backgroundColor: isFollowed ? Colors.green : Colors.indigo,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HobbyIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  const _HobbyIcon({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.indigo, size: 22),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
      ],
    );
  }
}
