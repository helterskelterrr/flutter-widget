## Daftar Isi

1. [MaterialApp](#1-materialapp)
2. [StatelessWidget](#2-statelesswidget)
3. [StatefulWidget dan State](#3-statefulwidget-dan-state)
4. [MediaQuery](#4-mediaquery)
5. [Scaffold](#5-scaffold)
6. [AppBar](#6-appbar)
7. [SingleChildScrollView](#7-singlechildscrollview)
8. [Center](#8-center)
9. [Container](#9-container)
10. [Column](#10-column)
11. [AspectRatio](#11-aspectratio)
12. [Image.asset](#12-imageasset)
13. [SizedBox](#13-sizedbox)
14. [Text dan TextStyle](#14-text-dan-textstyle)
15. [Row](#15-row)
16. [Icon](#16-icon)
17. [IconButton](#17-iconbutton)

---

## 1. MaterialApp
Widget root yang mengatur tema gelap global (`Brightness.dark`) dan skema warna khusus Witcher.

```dart
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
```

---

## 2. StatelessWidget
Widget yang bersifat statis. Digunakan untuk membangun struktur halaman utama `RowColumnPage`.

```dart
class RowColumnPage extends StatelessWidget {
  const RowColumnPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ... layout statis
  }
}
```

---

## 3. StatefulWidget dan State
Widget dinamis yang menyimpan status `_isFollowed` dan jumlah `_counter`.

```dart
class CounterCard extends StatefulWidget { ... }

class _CounterCardState extends State<CounterCard> {
  bool _isFollowed = false;
  int _counter = 1500;

  void _toggleFollow() {
    setState(() {
      _isFollowed = !_isFollowed;
      if (_isFollowed) _counter++;
      else _counter--;
    });
  }
  // ...
}
```

---

## 4. MediaQuery
Digunakan untuk mengambil informasi lebar layar agar Container dapat menyesuaikan ukurannya secara responsif.

```dart
MediaQueryData mediaQueryData = MediaQuery.of(context);
double screenWidth = mediaQueryData.size.width;
```

---

## 5. Scaffold
Menyediakan struktur halaman utama dengan warna latar belakang gelap.

```dart
return Scaffold(
  appBar: AppBar(...),
  body: SingleChildScrollView(...),
);
```

---

## 6. AppBar
Menampilkan judul di bagian atas dengan gaya teks Witcher dan bayangan berwarna merah tua.

```dart
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
```

---

## 7. SingleChildScrollView
Memungkinkan konten di dalam body dapat digulir (scroll) jika ukurannya melebihi layar.

```dart
body: SingleChildScrollView(
  child: Column(...),
),
```

---

## 8. Center
Digunakan untuk menempatkan gambar tepat di tengah container profil.

```dart
child: Center(
  child: Image.asset(...),
),
```

---

## 9. Container
Digunakan secara ekstensif untuk membungkus berbagai bagian (Foto, Bio, Hobi, Counter) dengan pengaturan margin, padding, dan warna latar belakang yang berbeda.

```dart
Container(
  width: screenWidth,
  margin: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 10.0),
  padding: const EdgeInsets.all(20.0),
  color: const Color(0xFF292929),
  child: const Column(...),
),
```

---

## 10. Column
Menyusun elemen secara vertikal di dalam halaman maupun di dalam Container.

```dart
child: Column(
  children: [
    Text('Geralt of Rivia', ...),
    SizedBox(height: 8),
    Text('...', ...),
  ],
),
```

---

## 11. AspectRatio
Memastikan container pembungkus gambar profil tetap berbentuk kotak (1:1).

```dart
child: AspectRatio(
  aspectRatio: 1.0,
  child: Container(...),
),
```

---

## 12. Image.asset
Menampilkan aset gambar lokal dengan pengaturan lebar dan penanganan error jika gambar tidak ditemukan.

```dart
Image.asset(
  'gambar/geralt-of-rivia-icon-the-witcher-3-wild-hunt-wiki-guide.png',
  fit: BoxFit.cover,
  width: 500,
  errorBuilder: (context, error, stack) => const Icon(
    Icons.person,
    size: 100,
    color: Color(0xFF555555),
  ),
),
```

---

## 13. SizedBox
Memberikan jarak vertikal atau horizontal antar widget.

```dart
const SizedBox(height: 8),
```

---

## 14. Text dan TextStyle
Menampilkan informasi teks dengan kustomisasi font, warna, dan perataan (alignment).

```dart
Text(
  'Geralt of Rivia',
  style: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  )
),
```

---

## 15. Row
Menyusun elemen secara horizontal, seperti pada bagian ikon hobi dan baris counter.

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: <Widget>[
    Column(...), // Hobby 1
    Column(...), // Hobby 2
    Column(...), // Hobby 3
  ],
),
```

---

## 16. Icon
Menampilkan simbol visual untuk hobi (Combat, Alchemy, Gwent) dan status follow.

```dart
Icon(Icons.sports_martial_arts, color: Color(0xFFD4AF37)),
```

---

## 17. IconButton
Tombol berbentuk ikon yang digunakan untuk memicu fungsi Follow/Unfollow.

```dart
IconButton(
  onPressed: _toggleFollow,
  icon: Icon(
      _isFollowed ? Icons.check : Icons.person_add,
      color: _isFollowed ? Colors.black : Colors.white,
      size: 20
  ),
),
```
