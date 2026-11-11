## 👤 Identitas Mahasiswa
* **Nama:** Nabilah Putri Ayli
* **NIM:** 241401091 
* **Lab:** Lab PM 6

---

## 📱 Informasi Aplikasi

### 1. Nama Aplikasi
**Quizly** (Kuisin)

### 2. Deskripsi Singkat
**Quizly** adalah aplikasi kuis pilihan ganda berbasis mobile dan web yang membantu mahasiswa Ilmu Komputer USU dalam menguji pemahaman mata kuliah semester (seperti *Pemrograman Mobile*, *Grafika Komputer*, *Etika Profesi*, *Penjaminan Kualitas Perangkat Lunak*, *Kecerdasan Buatan*, dan *Metodologi Penelitian*). Aplikasi ini dilengkapi dengan manajemen state yang modular, dual-theme (Dark/Light mode), layout responsif & adaptif, serta sistem riwayat belajar interaktif.

### 3. Fitur-Fitur Utama

#### Fitur Wajib (Core Requirements):
* **StatelessWidget & StatefulWidget:** Penerapan widget sesuai peruntukan komponen statis dan dinamis.
* **Multi-Page Navigation:** Navigasi antarhalaman menggunakan `Navigator` dan `NavigationBar` (Login, Beranda, Layar Kuis, Hasil & Pembahasan, Riwayat, dan Profil).
* **Reusable Widgets:** Komponen UI modular terpisah (seperti `CustomButton`, `OptionCard`, dan `ResponsiveWrapper`).
* **Kustomisasi Font & Aset:** Menggunakan kustom font **Poppins** dan aset ilustrasi kuis.
* **Layout Dinamis & Bebas Overflow:** Penyesuaian ukuran elemen UI secara otomatis menggunakan `MediaQuery` dan `LayoutBuilder` (tidak ada nilai dimensi hardcoded).
* **State Management (Provider):** Jawaban pengguna, progres kuis, dan pilihan tema tidak hilang ketika layar diputar (rotasi) atau saat berpindah antarhalaman.
* **Local Data Management:** Penyimpanan data bersifat lokal tanpa ketergantungan database eksternal.
* **Git Version Control Tracking:** Pelacakan komit bertahap pada setiap pengembangan fitur di GitHub.

#### Fitur Tambahan (Bonus Points):
* **Dual-Theme (Dark & Light Mode):** Pengalihan tema gelap dan terang secara instan di seluruh halaman aplikasi.
* **Adaptive & Responsive Layout:** Penyesuaian tampilan dari layar ponsel (1 kolom) ke layar lebar tablet/browser web (2 kolom adaptif).
* **Sistem Kategori Mata Kuliah (KRS USU):** Kuis dikelompokkan berdasarkan daftar mata kuliah semester berjalan.
* **Riwayat Belajar & Statistik:** Pencatatan skor otomatis, ringkasan jumlah kuis selesai, serta filter pembahasan jawaban (Semua, Benar, Salah).
* **Autentikasi Login & Profil:** Simulasi halaman masuk mahasiswa lengkap dengan validasi form dan manajemen akun sederhana.

---

## 🖼️ Dokumentasi

### 1. Credits & Sumber Aset
* **Framework:** [Flutter SDK](https://flutter.dev)
* **Font:** [Poppins Font Family by Indian Type Foundry (Google Fonts)](https://fonts.google.com/specimen/Poppins)
* **State Management:** [Provider Package](https://pub.dev/packages/provider)
* **Icons:** Material Design Icons bawaan Flutter
* **Illustrations:** Custom PNG & Material Vector Graphics

### 2. Tangkapan Layar Aplikasi (Screenshots)

| 1. Halaman Login | 2. Beranda Kuis | 3. Layar Kuis |
| :---: | :---: | :---: |
| *(Tampilkan Screenshot Login)* | *(Tampilkan Screenshot Beranda)* | *(Tampilkan Screenshot Kuis)* |

| 4. Hasil & Pembahasan | 5. Riwayat Belajar | 6. Halaman Profil |
| :---: | :---: | :---: |
| *(Tampilkan Screenshot Hasil)* | *(Tampilkan Screenshot Riwayat)* | *(Tampilkan Screenshot Profil)* |

### 3. Link Prototype / Mockup
* **Figma Prototype:** [Link Prototype Kuisin di Figma](https://figma.com) *(Tempelkan link Figma kamu di sini)*

---

## 🎤 Panduan Presentasi (5 Menit)

Saat melakukan demonstrasi di depan Asisten Lab (Muhammad Dzakwan Attaqiy / DZK), ikuti struktur penjelasan berikut:

1. **Fungsionalitas Aplikasi (1.5 Menit):**
   * Demo alur mulai dari **Login** $\rightarrow$ **Beranda** (pilihan kuis per mata kuliah) $\rightarrow$ **Layar Kuis** $\rightarrow$ **Layar Hasil & Pembahasan** $\rightarrow$ **Riwayat** $\rightarrow$ **Profil**.
2. **Responsivitas Aplikasi (1 Menit):**
   * Tunjukkan aplikasi saat dirotasi ke orientasi **Landscape** atau dijalankan di browser **Chrome (Web)** untuk memperlihatkan pembagian layout 2 kolom adaptif (`LayoutBuilder`).
3. **Alur & Implementasi Kode (1.5 Menit):**
   * Jelaskan peran `QuizProvider` dalam menjaga data agar tidak reset saat rotasi layar.
   * Tunjukkan pemisahan reusable widget (`custom_button.dart`, `option_card.dart`, `responsive_wrapper.dart`).
4. **Penjelasan Fitur Tambahan (1 Menit):**
   * Demokan pengubahan **Dark/Light Mode** dan sistem filter riwayat kuis per mata kuliah.