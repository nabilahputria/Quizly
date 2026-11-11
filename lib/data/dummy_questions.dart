import '../models/question_model.dart';

const List<Question> dummyQuestions = [
  // === PEMROGRAMAN MOBILE (ILK3105) ===
  Question(
    id: 'pm1',
    course: 'Pemrograman Mobile',
    category: 'Widget & UI',
    questionText: 'Widget manakah yang digunakan ketika UI tidak mengalami perubahan state selama runtime?',
    options: ['StatefulWidget', 'StatelessWidget', 'InheritedWidget', 'StreamBuilder'],
    correctOptionIndex: 1,
  ),
  Question(
    id: 'pm2',
    course: 'Pemrograman Mobile',
    category: 'State Management',
    questionText: 'Method apa yang dipanggil di dalam StatefulWidget untuk memicu rebuild UI saat data berubah?',
    options: ['initState()', 'dispose()', 'setState()', 'buildContext()'],
    correctOptionIndex: 2,
  ),
  Question(
    id: 'pm3',
    course: 'Pemrograman Mobile',
    category: 'Responsive Layout',
    questionText: 'Class bawaan Flutter untuk mendapatkan dimensi lebar dan tinggi layar secara dinamis adalah...',
    options: ['MediaQuery', 'ThemeData', 'BoxDecoration', 'EdgeInsets'],
    correctOptionIndex: 0,
  ),

  // === GRAFIKA KOMPUTER (ILK3103) ===
  Question(
    id: 'gk1',
    course: 'Grafika Komputer',
    category: '3D & Rendering',
    questionText: 'Fungsi OpenGL yang digunakan untuk mengatur posisi dan arah kamera dalam ruang 3D adalah...',
    options: ['glViewport()', 'gluLookAt()', 'glMatrixMode()', 'glLoadIdentity()'],
    correctOptionIndex: 1,
  ),
  Question(
    id: 'gk2',
    course: 'Grafika Komputer',
    category: 'Upscaling & Performance',
    questionText: 'Teknik rendering upscaling yang memanfaatkan temporal data untuk meningkatkan FPS adalah...',
    options: ['Bilinear Filtering', 'Bicubic Interpolation', 'DLSS / FSR', 'Ray Tracing'],
    correctOptionIndex: 2,
  ),

  // === ETIKA PROFESI (ILK3102) ===
  Question(
    id: 'ep1',
    course: 'Etika Profesi',
    category: 'Regulasi AI Global',
    questionText: 'Regulasi AI global komprehensif pertama yang mengklasifikasikan tingkat risiko sistem AI adalah...',
    options: ['EU AI Act', 'US Executive Order', 'Peta Jalan Komdigi RI', 'UNESCO AI Guidelines'],
    correctOptionIndex: 0,
  ),

  // === PENJAMINAN KUALITAS PERANGKAT LUNAK (ILK3110) ===
  Question(
    id: 'sqa1',
    course: 'Penjaminan Kualitas Perangkat Lunak',
    category: 'Defect Prediction',
    questionText: 'Indikator pada kode sumber yang menandakan adanya potensi kelemahan desain sistem disebut...',
    options: ['Code Smell', 'Memory Leak', 'Syntax Error', 'Deadlock'],
    correctOptionIndex: 0,
  ),
  Question(
    id: 'sqa2',
    course: 'Penjaminan Kualitas Perangkat Lunak',
    category: 'Software Testing',
    questionText: 'Pengujian perangkat lunak tanpa melihat struktur kode internal program disebut...',
    options: ['White Box Testing', 'Black Box Testing', 'Unit Testing', 'Code Review'],
    correctOptionIndex: 1,
  ),

  // === KECERDASAN BUATAN (ILK3107) ===
  Question(
    id: 'kb1',
    course: 'Kecerdasan Buatan',
    category: 'Machine Learning',
    questionText: 'Algoritma pembelajaran yang membutuhkan data berlabel (labeled data) dalam pelatihannya adalah...',
    options: ['Supervised Learning', 'Unsupervised Learning', 'Clustering', 'K-Means'],
    correctOptionIndex: 0,
  ),

  // === METODOLOGI PENELITIAN (ILK3101) ===
  Question(
    id: 'metpen1',
    course: 'Metodologi Penelitian',
    category: 'Publikasi Ilmiah',
    questionText: 'Nomor standar internasional yang digunakan untuk mengidentifikasi terbitan berkala/jurnal adalah...',
    options: ['ISBN', 'ISSN', 'DOI', 'ORCID'],
    correctOptionIndex: 1,
  ),
];