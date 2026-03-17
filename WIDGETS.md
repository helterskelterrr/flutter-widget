## Daftar Isi

1. [MaterialApp](#1-materialapp)
2. [StatelessWidget](#2-statelesswidget)
3. [StatefulWidget dan State](#3-statefulwidget-dan-state)
4. [MediaQuery](#4-mediaquery)
5. [Scaffold](#5-scaffold)
6. [AppBar](#6-appbar)
7. [Center](#7-center)
8. [Padding](#8-padding)
9. [Container](#9-container)
10. [BoxDecoration](#10-boxdecoration)
11. [Column](#11-column)
12. [ClipOval](#12-clipoval)
13. [AspectRatio](#13-aspectratio)
14. [Image.asset](#14-imageasset)
15. [SizedBox](#15-sizedbox)
16. [Text dan TextStyle](#16-text-dan-textstyle)
17. [Divider](#17-divider)
18. [Row](#18-row)
19. [Icon](#19-icon)
20. [ElevatedButton.icon](#20-elevatedbuttonicon)

---

## 1. MaterialApp
Widget root yang mengatur tema global dan navigasi aplikasi.

```dart
return MaterialApp(
  debugShowCheckedModeBanner: false,
  title: 'Geralt Profile Card',
  theme: ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
    useMaterial3: true,
  ),
  home: const ProfilePage(),
);
```

---

## 2. StatelessWidget
Widget yang tidak memiliki state internal yang dapat berubah. UI-nya murni ditentukan oleh data yang diterima melalui konstruktor.

```dart
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
  // ...
}
```

---

## 3. StatefulWidget dan State
Widget yang dapat menyimpan data yang berubah (state) selama aplikasi berjalan, seperti status follow dan jumlah pengikut.

```dart
class _ProfilePageState extends State<ProfilePage> {
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
  // ...
}
```

---

## 4. MediaQuery
Digunakan untuk membuat UI yang responsif dengan mengambil informasi ukuran layar perangkat.

```dart
double screenWidth = MediaQuery.of(context).size.width;
```

---

## 5. Scaffold
Menyediakan struktur dasar layout visual Material Design.

```dart
return Scaffold(
  backgroundColor: const Color(0xFFF0F2F5),
  appBar: AppBar(...),
  body: Center(...),
);
```

---

## 6. AppBar
Menampilkan bar di bagian atas aplikasi dengan judul dan warna latar.

```dart
appBar: AppBar(
  backgroundColor: Colors.indigo,
  centerTitle: true,
  title: const Text(
    'Witcher Profile',
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  ),
),
```

---

## 7. Center
Memastikan widget di dalamnya berada tepat di tengah ruang yang tersedia.

```dart
body: Center(
  child: ProfileCard(...),
),
```

---

## 8. Padding
Memberikan jarak kosong (internal spacing) di sekeliling widget anaknya.

```dart
child: Padding(
  padding: const EdgeInsets.all(28.0),
  child: Column(...),
),
```

---

## 9. Container
Widget serbaguna yang menggabungkan dekorasi, padding, dan batasan ukuran.

```dart
return Container(
  width: screenWidth * 0.85,
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(24),
    boxShadow: const [...],
  ),
  child: Padding(...),
);
```

---

## 10. BoxDecoration
Digunakan oleh Container untuk mengatur styling visual seperti warna, border, dan bayangan.

```dart
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
```

---

## 11. Column
Menata elemen secara vertikal dari atas ke bawah.

```dart
child: Column(
  mainAxisSize: MainAxisSize.min,
  children: [
    Container(...), // Profile Image
    const SizedBox(height: 16),
    const Text('Geralt of Rivia', ...),
    // ...
  ],
),
```

---

## 12. ClipOval
Memotong widget anaknya menjadi bentuk lingkaran atau oval.

```dart
child: ClipOval(
  child: AspectRatio(
    aspectRatio: 1.0,
    child: Image.asset(...),
  ),
),
```

---

## 13. AspectRatio
Memastikan widget anaknya mempertahankan rasio dimensi tertentu (lebar:tinggi).

```dart
child: AspectRatio(
  aspectRatio: 1.0,
  child: Image.asset(...),
),
```

---

## 14. Image.asset
Menampilkan gambar dari folder aset lokal proyek.

```dart
child: Image.asset(
  'gambar/geralt-of-rivia-icon-the-witcher-3-wild-hunt-wiki-guide.png',
  fit: BoxFit.cover,
  errorBuilder: (context, error, stack) => const Icon(
    Icons.person,
    size: 80,
    color: Colors.indigo,
  ),
),
```

---

## 15. SizedBox
Digunakan untuk memberikan jarak statis (spasi) antar elemen UI.

```dart
const SizedBox(height: 16),
```

---

## 16. Text dan TextStyle
Menampilkan teks dengan berbagai gaya (ukuran, warna, ketebalan font).

```dart
const Text(
  'Geralt of Rivia',
  style: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.indigo,
  ),
),
```

---

## 17. Divider
Menampilkan garis pemisah horizontal yang tipis.

```dart
const Divider(height: 1, color: Color(0xFFE0E0E0)),
```

---

## 18. Row
Menata elemen secara horizontal dari kiri ke kanan.

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: const [
    _HobbyIcon(icon: Icons.sports_martial_arts, label: 'Combat'),
    SizedBox(width: 20),
    // ...
  ],
),
```

---

## 19. Icon
Menampilkan simbol grafis dari library material icons.

```dart
const Icon(Icons.people, color: Colors.indigo, size: 20),
```

---

## 20. ElevatedButton.icon
Tombol interaktif yang menggabungkan ikon dan label teks, mendukung aksi klik.

```dart
ElevatedButton.icon(
  onPressed: onFollowToggle,
  icon: Icon(isFollowed ? Icons.check : Icons.person_add, size: 18),
  label: Text(isFollowed ? 'Following' : 'Follow'),
  style: ElevatedButton.styleFrom(
    backgroundColor: isFollowed ? Colors.green : Colors.indigo,
    foregroundColor: Colors.white,
    // ...
  ),
),
```
