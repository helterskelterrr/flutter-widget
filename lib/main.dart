import 'package:flutter/material.dart';

// Entry point of the app
void main() {
  runApp(const MyApp());
}

// MyApp — root widget (StatelessWidget)
// Sets up MaterialApp with theme and home page.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile Card App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const ProfilePage(), // Start directly on the profile page
    );
  }
}

// ProfilePage — StatefulWidget
// Owns the "isFollowed" state and passes it
// down to ProfileCard for display.
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isFollowed = false;

  // Called when the Follow / Unfollow button is pressed.
  void _toggleFollow() {
    setState(() {
      _isFollowed = !_isFollowed; // Flip the value
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
          'Profile Card',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: ProfileCard(
          isFollowed: _isFollowed,
          onFollowToggle: _toggleFollow,
        ),
      ),
    );
  }
}

// ProfileCard — StatelessWidget
// Pure display widget. Receives data via
// constructor and renders the card layout.
class ProfileCard extends StatelessWidget {
  final bool isFollowed;
  final VoidCallback onFollowToggle;

  const ProfileCard({
    super.key,
    required this.isFollowed,
    required this.onFollowToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
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
              // ── Profile Image
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.indigo, width: 3),
                ),
                child: ClipOval(
                  child: Image.asset(
                    'gambar/WhatsApp Image 2026-03-16 at 11.35.31.jpeg',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stack) => const Icon(
                      Icons.person,
                      size: 80,
                      color: Colors.indigo,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Name
              const Text(
                'Nadief Aqila Rabbani',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),

              const SizedBox(height: 6),

              // Short Description
              const Text(
                'Game Designer, Game Developer, and ML Engineer\nBased in Sidoarjo, Indonesia.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 20),

              // Divider
              const Divider(height: 1, color: Color(0xFFE0E0E0)),

              const SizedBox(height: 20),

              // Hobby / Skill Icons Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  _HobbyIcon(icon: Icons.code, label: 'Code'),
                  SizedBox(width: 24),
                  _HobbyIcon(icon: Icons.brush, label: 'Design'),
                  SizedBox(width: 24),
                  _HobbyIcon(icon: Icons.music_note, label: 'Music'),
                  SizedBox(width: 24),
                  _HobbyIcon(icon: Icons.sports_esports, label: 'Gaming'),
                ],
              ),

              const SizedBox(height: 24),

              // Follow / Unfollow Button
              ElevatedButton.icon(
                onPressed: onFollowToggle,
                icon: Icon(
                  isFollowed ? Icons.check : Icons.add,
                  size: 18,
                ),
                label: Text(
                  isFollowed ? 'Following' : 'Follow',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  // Button turns green when followed, indigo when not
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
      ),
    );
  }
}

// HobbyIcon — private StatelessWidget
// A small reusable widget for a single hobby:
// an Icon above a short label text.
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
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.grey),
        ),
      ],
    );
  }
}
