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

`MaterialApp` adalah widget root yang membungkus seluruh aplikasi. Widget ini menyediakan infrastruktur navigasi, tema global, dan berbagai konfigurasi tingkat aplikasi. Tanpa `MaterialApp`, widget Material Design seperti `Scaffold`, `AppBar`, dan `ElevatedButton` tidak akan berfungsi karena semua widget tersebut membutuhkan konteks Material yang disediakan oleh `MaterialApp`.

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

**Parameter yang digunakan:**

| Parameter | Fungsi |
|---|---|
| `debugShowCheckedModeBanner` | Menyembunyikan label "DEBUG" di pojok kanan atas |
| `title` | Nama aplikasi yang muncul di task switcher sistem operasi |
| `theme` | Mendefinisikan tema visual global menggunakan `ThemeData` |
| `home` | Widget pertama yang ditampilkan saat aplikasi dibuka |

`ColorScheme.fromSeed` secara otomatis menghasilkan palet warna yang harmonis berdasarkan satu warna seed, dalam hal ini `Colors.indigo`. `useMaterial3: true` mengaktifkan spesifikasi desain Material 3 (Material You).

---

## 2. StatelessWidget

`StatelessWidget` adalah widget yang tidak memiliki state internal yang dapat berubah. Setelah dibangun dengan suatu konfigurasi, tampilanya tidak akan berubah kecuali widget dihancurkan dan dibangun ulang dari luar oleh widget induknya. Widget ini cocok digunakan untuk komponen yang bersifat murni display dan tidak menyimpan data yang bisa dimutasi.

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // ... konfigurasi aplikasi
    );
  }
}
```

```dart
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
    // ... layout kartu profil
  }
}
```

Dalam proyek ini, `StatelessWidget` digunakan oleh tiga class: `MyApp`, `ProfileCard`, dan `_HobbyIcon`. Ketiganya menerima data dari luar melalui konstruktor dan tidak perlu mengelola state sendiri.

**Alur data pada `ProfileCard`:** data mengalir dari `_ProfilePageState` (induk) ke `ProfileCard` melalui parameter konstruktor `isFollowed` dan `onFollowToggle`. Pola ini dikenal sebagai *unidirectional data flow*.

---

## 3. StatefulWidget dan State

`StatefulWidget` adalah widget yang dapat menyimpan dan mengubah state internal. Ketika `setState()` dipanggil, Flutter menjadwalkan rebuild pada widget tersebut sehingga UI diperbarui sesuai state terbaru.

```dart
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _isFollowed = false;

  void _toggleFollow() {
    setState(() {
      _isFollowed = !_isFollowed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ...
      body: Center(
        child: ProfileCard(
          isFollowed: _isFollowed,
          onFollowToggle: _toggleFollow,
        ),
      ),
    );
  }
}
```

`StatefulWidget` terdiri dari dua class yang saling berpasangan:
- **Widget class** (`ProfilePage`): bersifat immutable, bertugas membuat objek `State`.
- **State class** (`_ProfilePageState`): menyimpan data yang dapat berubah dan mengandung logika `build()`.

Pemisahan ini disengaja oleh Flutter agar Flutter dapat mempertahankan objek `State` meskipun widget tree mengalami rebuild.

`setState()` berfungsi sebagai sinyal ke framework bahwa state telah berubah dan `build()` perlu dijalankan ulang. Mendapatkan nilai baru di dalam closure `setState()` dijamin akan terrefleksi pada `build()` berikutnya.

**Pola callback:** `_toggleFollow` diteruskan ke `ProfileCard` sebagai `VoidCallback`. Ini adalah cara standar agar widget anak dapat memicu perubahan state di widget induk tanpa bergantung pada state management eksternal.

---

## 4. Scaffold

`Scaffold` menyediakan struktur visual standar halaman Material Design. Widget ini mengimplementasikan layout dasar halaman yang mencakup area untuk `AppBar`, `body`, `floatingActionButton`, `bottomNavigationBar`, dan sebagainya.

```dart
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
```

`backgroundColor: const Color(0xFFF0F2F5)` menetapkan warna latar halaman menggunakan format hex ARGB (alpha, red, green, blue). Nilai `0xFF` pada prefiks berarti opasitas penuh (255/255). Warna ini menghasilkan abu-abu terang yang umum digunakan sebagai latar belakang aplikasi modern.

---

## 5. AppBar

`AppBar` adalah panel horizontal di bagian atas layar yang biasanya memuat judul halaman, tombol navigasi, dan action item. AppBar dirender di dalam slot `appBar` milik `Scaffold`.

```dart
appBar: AppBar(
  backgroundColor: Colors.indigo,
  centerTitle: true,
  title: const Text(
    'Profile Card',
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  ),
),
```

Secara default pada Material 3, judul `AppBar` rata kiri. Properti `centerTitle: true` mengubahnya menjadi terpusat, yang merupakan konvensi umum pada desain mobile.

---

## 6. Center

`Center` adalah single-child layout widget yang mengposisikan child-nya tepat di tengah ruang yang tersedia, baik secara horizontal maupun vertikal.

```dart
body: Center(
  child: ProfileCard(
    isFollowed: _isFollowed,
    onFollowToggle: _toggleFollow,
  ),
),
```

`Center` bekerja dengan constraint: ia meneruskan constraint tak terbatas ke child-nya, lalu menempatkan child di tengah berdasarkan ukuran yang child laporkan kembali. Dalam konteks `Scaffold.body`, `Center` mendapatkan seluruh area layar (dikurangi `AppBar`) sebagai ruang kerjanya.

---

## 7. Padding

`Padding` menambahkan jarak kosong (inset) di sekeliling child-nya tanpa mengubah ukuran atau posisi child dalam makna layoutnya. Widget ini berbeda dari `margin` pada `Container` dalam hal ia hanya memiliki satu tujuan dan lebih efisien secara widget tree.

```dart
return Padding(
  padding: const EdgeInsets.symmetric(horizontal: 24.0),
  child: Container(
    // ... kartu profil
  ),
);
```

```dart
child: Padding(
  padding: const EdgeInsets.all(28.0),
  child: Column(/* ... */),
),
```

`EdgeInsets.symmetric(horizontal: 24.0)` menambahkan padding 24 logical pixel di sisi kiri dan kanan, memberikan margin horizontal antara kartu dan tepi layar. `EdgeInsets.all(28.0)` menambahkan padding merata di semua sisi, menciptakan ruang napas di dalam kartu.

---

## 8. Container

`Container` adalah widget serba guna yang menggabungkan kemampuan painting (warna, dekorasi), positioning, dan sizing dalam satu widget. Secara internal, `Container` adalah facade yang merangkum beberapa widget primitif seperti `DecoratedBox`, `ConstrainedBox`, dan `Align`.

```dart
Container(
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
  child: Padding(/* ... */),
)
```

```dart
// Container untuk foto profil bulat
Container(
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    border: Border.all(color: Colors.indigo, width: 3),
  ),
  child: ClipOval(/* ... */),
)
```

```dart
// Container untuk ikon hobi
Container(
  padding: const EdgeInsets.all(10),
  decoration: BoxDecoration(
    color: Colors.indigo.shade50,
    shape: BoxShape.circle,
  ),
  child: Icon(icon, color: Colors.indigo, size: 22),
)
```

**Perilaku ukuran `Container`:** Bila tidak diberikan `width`/`height` eksplisit, `Container` akan menyesuaikan ukurannya dengan child-nya (shrink-wrap) jika berada dalam constraint tak terbatas, atau meluaskan diri untuk memenuhi constraint jika tidak ada child.

---

## 9. BoxDecoration

`BoxDecoration` adalah objek dekorasi yang digunakan oleh `Container` (atau `DecoratedBox`) untuk mendefinisikan tampilan visual seperti warna, border, border radius, bayangan, dan bentuk.

```dart
BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(24),
  boxShadow: const [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 16,
      offset: Offset(0, 6),
    ),
  ],
)
```

**Komponen `BoxShadow`:**

| Parameter | Nilai | Efek |
|---|---|---|
| `color` | `Colors.black12` | Warna bayangan dengan opasitas 12% |
| `blurRadius` | `16` | Seberapa blur bayangan, makin besar makin difus |
| `offset` | `Offset(0, 6)` | Pergeseran bayangan: 0 horizontal, 6px ke bawah |

`BorderRadius.circular(24)` menghasilkan sudut membulat dengan radius 24 pixel di seluruh sisi, memberikan tampilan kartu yang modern dan lunak.

`BoxShape.circle` mengubah bentuk dekorasi menjadi lingkaran sempurna, digunakan pada bingkai foto profil dan latar ikon hobi.

---

## 10. Column

`Column` adalah multi-child layout widget yang menata children secara vertikal dari atas ke bawah. Ini adalah salah satu widget layout paling fundamental di Flutter.

```dart
Column(
  mainAxisSize: MainAxisSize.min,
  children: [
    Container(/* foto profil */),
    const SizedBox(height: 16),
    const Text('Nadief Aqila Rabbani', /* ... */),
    const SizedBox(height: 6),
    const Text('Game Designer...', /* ... */),
    const SizedBox(height: 20),
    const Divider(/* ... */),
    const SizedBox(height: 20),
    Row(/* ikon hobi */),
    const SizedBox(height: 24),
    ElevatedButton.icon(/* tombol follow */),
  ],
)
```

```dart
// Column dalam _HobbyIcon
Column(
  children: [
    Container(/* ikon */),
    const SizedBox(height: 6),
    Text(label, /* ... */),
  ],
)
```

`mainAxisSize: MainAxisSize.min` membuat `Column` hanya mengambil tinggi sebesar yang dibutuhkan children-nya, bukan memenuhi seluruh tinggi yang tersedia. Ini penting agar kartu tidak merentang ke seluruh tinggi layar.

**Main axis** pada `Column` adalah sumbu vertikal (Y). **Cross axis** adalah sumbu horizontal (X).

---

## 11. ClipOval

`ClipOval` memotong (clip) child-nya menjadi bentuk oval atau lingkaran. Ketika dimensi child adalah persegi (lebar = tinggi), hasilnya adalah lingkaran sempurna.

```dart
ClipOval(
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
```

`ClipOval` bekerja dengan cara menetapkan clip path berbentuk lingkaran/oval sebelum child-nya dirender ke kanvas. Piksel yang berada di luar area clip tidak akan digambar. Ini berbeda dari `BorderRadius` pada `BoxDecoration` yang hanya mengubah dekorasi container, bukan memotong konten di dalamnya.

---

## 12. Image.asset

`Image.asset` adalah konstruktor named dari widget `Image` yang memuat gambar dari asset lokal yang telah didaftarkan di `pubspec.yaml`. Widget ini menggunakan `AssetBundleImageProvider` di balik layar untuk membaca berkas gambar dari bundle aplikasi.

```dart
Image.asset(
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
```

`BoxFit.cover` memastikan gambar memenuhi seluruh area target (100x100) dengan mempertahankan aspek rasio. Bagian gambar yang melebihi area akan dipotong. Ini adalah perilaku yang setara dengan `object-fit: cover` pada CSS.

`errorBuilder` adalah callback yang dipanggil jika gambar gagal dimuat, misalnya karena file tidak ditemukan. Ini memberikan fallback berupa ikon `Icons.person` sehingga UI tetap terjaga meskipun terjadi error.

---

## 13. SizedBox

`SizedBox` adalah widget layout yang memaksa child-nya (atau ruang kosong jika tidak ada child) memiliki dimensi tertentu. Penggunaan paling umum adalah sebagai spacer vertikal atau horizontal.

```dart
const SizedBox(height: 16),  // Jarak vertikal antar nama dan foto
const SizedBox(height: 6),   // Jarak kecil antar elemen
const SizedBox(height: 20),  // Jarak sebelum dan sesudah Divider
const SizedBox(height: 24),  // Jarak sebelum tombol
const SizedBox(width: 24),   // Jarak horizontal antar ikon hobi
```

`SizedBox` adalah widget yang sangat ringan (single render object). Sebagai spacer, ini lebih eksplisit dan semantik dibandingkan menggunakan `Padding` hanya di satu sisi. Di dalam `Column`, `SizedBox(height: n)` menghasilkan jarak vertikal sebesar `n` logical pixel. Di dalam `Row`, `SizedBox(width: n)` menghasilkan jarak horizontal.

---

## 14. Text dan TextStyle

`Text` merender string teks dengan satu gaya tipografi. `TextStyle` adalah objek konfigurasi yang menentukan tampilan teks tersebut.

```dart
// Judul nama
const Text(
  'Nadief Aqila Rabbani',
  style: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.indigo,
  ),
),
```

```dart
// Deskripsi singkat
const Text(
  'Game Designer, Game Developer, and ML Engineer\nBased in Sidoarjo, Indonesia.',
  textAlign: TextAlign.center,
  style: TextStyle(
    fontSize: 14,
    color: Colors.grey,
    height: 1.5,
  ),
),
```

```dart
// Label tombol dengan kondisi
Text(
  isFollowed ? 'Following' : 'Follow',
  style: const TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
  ),
),
```

**Catatan teknikal pada `TextStyle`:**
- `fontWeight: FontWeight.bold` setara dengan `FontWeight.w700`.
- `fontWeight: FontWeight.w600` adalah semi-bold, tingkat ketebalan antara regular dan bold.
- `height: 1.5` mendefinisikan line height sebagai kelipatan dari `fontSize`. Nilai `1.5` berarti jarak antar baris adalah 150% dari ukuran font, meningkatkan keterbacaan pada teks multi-baris.

---

## 15. Divider

`Divider` merender garis horizontal tipis yang digunakan sebagai pemisah visual antar seksi konten.

```dart
const Divider(height: 1, color: Color(0xFFE0E0E0)),
```

Parameter `height` pada `Divider` bukan tebal garisnya, melainkan total ruang vertikal yang dikonsumsi widget ini (termasuk padding di atas dan bawah garis). Tebal garis aktual dikontrol oleh parameter `thickness` yang secara default bernilai `1.0`. Dalam konteks ini, `height: 1` membuat divider tidak mengambil ruang vertikal ekstra, sementara `SizedBox` di atas dan di bawahnya yang mengatur jarak.

---

## 16. Row

`Row` adalah multi-child layout widget yang menata children secara horizontal dari kiri ke kanan. Merupakan pasangan dari `Column` pada sumbu horizontal.

```dart
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
)
```

`mainAxisAlignment: MainAxisAlignment.center` menempatkan seluruh children di tengah sumbu horizontal. Jarak antar ikon dikelola secara eksplisit menggunakan `SizedBox(width: 24)` daripada menggunakan `MainAxisAlignment.spaceEvenly`, memberikan kontrol yang lebih presisi atas jarak.

---

## 17. Icon

`Icon` merender ikon dari font ikon berbasis vektor (`IconData`). Flutter secara default menggunakan font Material Icons. Karena berbasis vektor, ikon ini tidak kehilangan kualitas pada ukuran berapa pun.

```dart
// Ikon hobi dalam _HobbyIcon
Icon(icon, color: Colors.indigo, size: 22)
```

```dart
// Ikon pada tombol — berubah sesuai state
Icon(
  isFollowed ? Icons.check : Icons.add,
  size: 18,
),
```

`IconData` (nilai dari `Icons.code`, `Icons.brush`, dll.) hanyalah referensi ke code point Unicode dalam font Material Icons. `Icon` widget kemudian merender karakter tersebut dengan ukuran dan warna yang ditentukan.

Penggunaan ekspresi kondisional `isFollowed ? Icons.check : Icons.add` adalah contoh penggunaan state untuk mengubah konten UI secara dinamis.

---

## 18. ElevatedButton.icon

`ElevatedButton.icon` adalah konstruktor named dari `ElevatedButton` yang secara khusus menampilkan kombinasi ikon dan teks dalam satu tombol. Secara internal, ia menggunakan `_ElevatedButtonWithIcon` yang mengatur tata letak ikon dan label secara horizontal.

```dart
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
    backgroundColor: isFollowed ? Colors.green : Colors.indigo,
    foregroundColor: Colors.white,
    minimumSize: const Size(double.infinity, 48),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
),
```

**Parameter styling:**

| Parameter | Nilai | Efek |
|---|---|---|
| `backgroundColor` | `Colors.green` / `Colors.indigo` | Warna latar tombol berubah sesuai state |
| `foregroundColor` | `Colors.white` | Warna teks dan ikon (child) secara otomatis |
| `minimumSize` | `Size(double.infinity, 48)` | Tombol melebar penuh dengan tinggi minimum 48px |
| `shape` | `RoundedRectangleBorder` | Bentuk tombol dengan sudut membulat |

`Size(double.infinity, 48)` pada `minimumSize` menyebabkan tombol mengisi seluruh lebar yang tersedia (dalam konteks `Column`, ini berarti lebar penuh kartu), menjadikannya elemen CTA (call-to-action) yang prominent.

`ElevatedButton.styleFrom` adalah metode statis helper yang mengkonversi parameter gaya sederhana menjadi `ButtonStyle` yang lengkap, termasuk penanganan state seperti hover, pressed, dan disabled secara otomatis.

---

## Ringkasan Arsitektur Widget

```
MyApp (StatelessWidget)
└── MaterialApp
    └── ProfilePage (StatefulWidget)
        └── Scaffold
            ├── AppBar
            │   └── Text
            └── Center
                └── ProfileCard (StatelessWidget)
                    └── Padding
                        └── Container  [kartu utama]
                            └── Padding
                                └── Column
                                    ├── Container  [bingkai foto]
                                    │   └── ClipOval
                                    │       └── Image.asset
                                    ├── SizedBox
                                    ├── Text  [nama]
                                    ├── SizedBox
                                    ├── Text  [deskripsi]
                                    ├── SizedBox
                                    ├── Divider
                                    ├── SizedBox
                                    ├── Row  [ikon hobi]
                                    │   └── _HobbyIcon x4 (StatelessWidget)
                                    │       └── Column
                                    │           ├── Container
                                    │           │   └── Icon
                                    │           ├── SizedBox
                                    │           └── Text
                                    ├── SizedBox
                                    └── ElevatedButton.icon
                                        ├── Icon
                                        └── Text
```

---

## Konsep Kunci

### Unidirectional Data Flow

State (`_isFollowed`) hanya dimiliki oleh `_ProfilePageState`. Data mengalir ke bawah melalui parameter konstruktor (`isFollowed`), sedangkan event mengalir ke atas melalui callback (`onFollowToggle`). Widget anak (`ProfileCard`) sepenuhnya stateless dan hanya merender apa yang diterimanya.

### const Constructor

Penggunaan `const` pada konstruktor widget (misalnya `const SizedBox(height: 16)`, `const Text(...)`) memungkinkan Flutter untuk menggunakan kembali instance yang sama di setiap rebuild tanpa mengalokasikan objek baru. Ini meningkatkan performa terutama pada widget yang sering direbuild.

### Komposisi Widget

Flutter tidak menggunakan inheritance untuk membangun UI yang kompleks. Sebaliknya, seluruh antarmuka dibangun melalui komposisi — menggabungkan widget-widget kecil dan sederhana menjadi struktur yang lebih besar. `_HobbyIcon` adalah contoh ideal: widget kecil yang dapat digunakan ulang, dibuat dari `Column`, `Container`, `Icon`, dan `Text`.
