# Dokumentasi Widget — Profile Card App

Dokumen ini menjelaskan seluruh widget Flutter yang digunakan dalam proyek **Profile Card App** secara teknikal. Setiap widget disertai potongan kode relevan dan penjelasan cara kerjanya dalam konteks proyek ini.

---

## Daftar Isi

1. [MaterialApp](#1-materialapp)
2. [StatelessWidget](#2-statelesswidget)
3. [StatefulWidget dan State](#3-statefulwidget-dan-state)
4. [Scaffold](#4-scaffold)
5. [AppBar](#5-appbar)
6. [Center](#6-center)
7. [Padding](#7-padding)
8. [Container](#8-container)
9. [BoxDecoration](#9-boxdecoration)
10. [Column](#10-column)
11. [ClipOval](#11-clipoval)
12. [Image.asset](#12-imageasset)
13. [SizedBox](#13-sizedbox)
14. [Text dan TextStyle](#14-text-dan-textstyle)
15. [Divider](#15-divider)
16. [Row](#16-row)
17. [Icon](#17-icon)
18. [ElevatedButton.icon](#18-elevatedbuttonicon)

---

## 1. MaterialApp

`MaterialApp` adalah widget root yang membungkus seluruh aplikasi. Widget ini menyediakan infrastruktur navigasi, tema global, dan berbagai konfigurasi tingkat aplikasi.

```dart
return MaterialApp(
  debugShowCheckedModeBanner: false,
  title: 'Profile Card App',
  theme: ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
    useMaterial3: true,
  ),
  home: const ProfilePage(),
);
```

---

## 2. StatelessWidget

`StatelessWidget` adalah widget yang tidak memiliki state internal yang dapat berubah. UI-nya murni ditentukan oleh data yang diterima melalui konstruktor.

```dart
class ProfileCard extends StatelessWidget {
  final bool isFollowed;
  final int counter; // State yang diteruskan dari induk
  final VoidCallback onFollowToggle;

  const ProfileCard({
    super.key,
    required this.isFollowed,
    required this.counter,
    required this.onFollowToggle,
  });

  @override
  Widget build(BuildContext context) {
    // ... layout kartu profil
  }
}
```

---

## 3. StatefulWidget dan State

`StatefulWidget` digunakan ketika widget perlu menyimpan data yang bisa berubah selama siklus hidupnya.

```dart
class _ProfilePageState extends State<ProfilePage> {
  bool _isFollowed = false;
  int _counter = 0; 

  void _toggleFollow() {
    setState(() {
      _isFollowed = !_isFollowed;
      if (_isFollowed) {
        _counter++; // Sinkronisasi: +1 saat follow
      } else {
        _counter--; // Sinkronisasi: -1 saat unfollow
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
```

---

## 8. Container

`Container` digunakan untuk berbagai tujuan, termasuk membungkus seksi **Followers Counter** dengan latar belakang warna yang berbeda.

```dart
// Container untuk Counter Section
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
      Text('Followers: $counter', /* ... */),
    ],
  ),
),
```

---

## 10. Column

`Column` menata elemen secara vertikal. Urutannya sekarang adalah: Foto -> Nama -> Bio -> Divider -> Hobby Row -> **Counter Section** -> Button.

---

## 14. Text dan TextStyle

Gaya teks digunakan secara dinamis untuk menampilkan jumlah pengikut menggunakan interpolasi string: `Text('Followers: $counter')`.

---

## 17. Icon

Ikon berubah secara dinamis berdasarkan status follow untuk memberikan feedback visual yang lebih baik.

```dart
Icon(
  isFollowed ? Icons.check : Icons.person_add,
  size: 18,
),
```

---

## Ringkasan Arsitektur Widget

```
ProfilePage (Stateful)
└── ProfileCard (Stateless)
    └── Column
        ├── Profile Image
        ├── Name & Bio
        ├── Divider
        ├── Hobby Row
        ├── Counter Section (Container + Row + Icon + Text)
        └── Follow Button
```

---

## Konsep Kunci: Sinkronisasi State

Aplikasi ini mendemonstrasikan logika bisnis yang sinkron: menekan tombol **Follow** tidak hanya mengubah label tombol, tetapi juga memperbarui jumlah **Followers** secara *real-time* (+1 atau -1). Ini memastikan pengalaman pengguna yang konsisten dan interaktif.
