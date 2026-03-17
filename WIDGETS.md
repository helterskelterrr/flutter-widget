# Dokumentasi Widget — Geralt Profile Card

Dokumen ini menjelaskan seluruh widget Flutter yang digunakan dalam proyek **Geralt Profile Card** secara teknikal. Setiap widget disertai potongan kode relevan dan penjelasan cara kerjanya dalam konteks proyek ini.

---

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

`MaterialApp` adalah widget root yang membungkus seluruh aplikasi. Widget ini menyediakan infrastruktur navigasi, tema global, dan berbagai konfigurasi tingkat aplikasi.

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

`StatelessWidget` adalah widget yang tidak memiliki state internal yang dapat berubah. UI-nya murni ditentukan oleh data yang diterima melalui konstruktor. Contoh: `ProfileCard` dan `_HobbyIcon`.

```dart
class ProfileCard extends StatelessWidget {
  // ... data diterima lewat konstruktor
  @override
  Widget build(BuildContext context) {
    // UI statis berdasarkan input
  }
}
```

---

## 3. StatefulWidget dan State

`StatefulWidget` digunakan ketika widget perlu menyimpan data yang bisa berubah selama siklus hidupnya, seperti status follow dan jumlah pengikut.

```dart
class _ProfilePageState extends State<ProfilePage> {
  bool _isFollowed = false;
  int _counter = 1500;

  void _toggleFollow() {
    setState(() {
      _isFollowed = !_isFollowed;
      if (_isFollowed) _counter++;
      else _counter--;
    });
  }
}
```

---

## 4. MediaQuery

`MediaQuery` digunakan untuk mendapatkan informasi ukuran layar secara real-time untuk membuat UI yang responsif.

```dart
double screenWidth = MediaQuery.of(context).size.width;
// Digunakan untuk: width: screenWidth * 0.85
```

---

## 5. Scaffold

`Scaffold` menyediakan struktur dasar layout visual Material Design, seperti `appBar`, `body`, dan `backgroundColor`.

---

## 6. AppBar

`AppBar` adalah bar bagian atas aplikasi yang menampilkan judul ("Witcher Profile") dengan warna latar belakang `indigo`.

---

## 7. Center

`Center` memastikan `ProfileCard` berada tepat di tengah layar baik secara vertikal maupun horizontal.

---

## 8. Padding

`Padding` memberikan ruang kosong di dalam `ProfileCard` (sebesar 28.0) agar elemen-elemen di dalamnya tidak menyentuh tepi kartu.

---

## 9. Container

`Container` adalah widget serbaguna yang digunakan sebagai pembungkus kartu profil (dengan dekorasi) dan pembungkus seksi counter.

---

## 10. BoxDecoration

`BoxDecoration` digunakan bersama `Container` untuk memberikan warna latar, radius sudut (`borderRadius`), serta efek bayangan (`boxShadow`).

---

## 11. Column

`Column` menata elemen-elemen secara vertikal (dari atas ke bawah): Foto -> Nama -> Bio -> Divider -> Hobby -> Counter -> Tombol.

---

## 12. ClipOval

`ClipOval` digunakan untuk memotong widget anaknya (dalam hal ini `AspectRatio` berisi gambar) menjadi bentuk oval/lingkaran sempurna.

---

## 13. AspectRatio

`AspectRatio` memastikan widget di dalamnya memiliki perbandingan lebar dan tinggi yang tetap (1:1), sehingga gambar Geralt tidak terlihat gepeng.

---

## 14. Image.asset

`Image.asset` memuat gambar dari folder lokal `gambar/`. Dilengkapi dengan `errorBuilder` untuk menampilkan ikon default jika file tidak ditemukan.

```dart
Image.asset(
  'gambar/geralt-of-rivia-icon-the-witcher-3-wild-hunt-wiki-guide.png',
  fit: BoxFit.cover,
)
```

---

## 15. SizedBox

`SizedBox` digunakan sebagai pemberi jarak (spasi) antar widget dengan menentukan nilai `height` atau `width` yang spesifik.

---

## 16. Text dan TextStyle

`Text` digunakan untuk menampilkan informasi string, sementara `TextStyle` mengatur ukuran font, ketebalan (`fontWeight`), dan warna teks.

---

## 17. Divider

`Divider` menampilkan garis horizontal tipis untuk memisahkan bagian biografi dengan bagian hobi.

---

## 18. Row

`Row` menata elemen secara horizontal. Digunakan untuk menampilkan deretan ikon hobi (Combat, Alchemy, Gwent).

---

## 19. Icon

`Icon` menampilkan simbol grafis dari library `Icons`. Ikon tombol Follow berubah secara dinamis antara `person_add` dan `check`.

---

## 20. ElevatedButton.icon

Widget tombol yang menyertakan ikon dan label teks. Warna tombol berubah secara dinamis: biru (`indigo`) saat belum di-follow, dan hijau (`green`) saat sudah di-follow.

---

## Ringkasan Arsitektur Widget

```
ProfilePage (Stateful)
└── Scaffold
    └── Center
        └── ProfileCard (Stateless)
            └── Column
                ├── Container (Profile Image + ClipOval + AspectRatio + Image.asset)
                ├── Text (Name)
                ├── Text (Bio)
                ├── Divider
                ├── Row (Hobby Icons)
                ├── Container (Counter Section)
                └── ElevatedButton.icon (Follow Button)
```

---

## Konsep Kunci: Responsivitas & Sinkronisasi State

1.  **Responsivitas**: Penggunaan `MediaQuery` memastikan kartu profil tampil proporsional (85% lebar layar) di berbagai ukuran perangkat.
2.  **Sinkronisasi State**: Fungsi `setState` dalam `ProfilePage` memastikan bahwa perubahan pada tombol Follow langsung memperbarui angka Followers secara bersamaan.
