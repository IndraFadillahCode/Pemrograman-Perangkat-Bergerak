class Mahasiswa {
  String nim, nama;
  double nilaiUts, nilaiTugas, nilaiUas;
  double nilaiAkhir = 0;  // Menginisialisasi dengan 0
  String nHuruf = "";     // Menginisialisasi dengan string kosong
  String predikat = "";   // Menginisialisasi dengan string kosong

  Mahasiswa(this.nim, this.nama, this.nilaiUts, this.nilaiTugas, this.nilaiUas);

  // Method untuk menghitung nilai akhir
  void hitungNilai() {
    double pNilaiUts = 0.30 * nilaiUts;
    double pNilaiTugas = 0.35 * nilaiTugas;
    double pNilaiUas = 0.35 * nilaiUas;
    nilaiAkhir = pNilaiUts + pNilaiTugas + pNilaiUas;
  }

  // Method untuk mendapatkan nilai huruf
  void getNilaiHuruf() {
    if (nilaiAkhir >= 85) {
      nHuruf = "A";
    } else if (nilaiAkhir >= 70) {
      nHuruf = "B";
    } else if (nilaiAkhir >= 60) {
      nHuruf = "C";
    } else if (nilaiAkhir >= 50) {
      nHuruf = "D";
    } else {
      nHuruf = "E";
    }
  }

  // Method untuk mendapatkan predikat
  void getPredikat() {
    switch (nHuruf) {
      case "A":
        predikat = "Sangat Baik";
        break;
      case "B":
        predikat = "Baik";
        break;
      case "C":
        predikat = "Cukup";
        break;
      case "D":
        predikat = "Kurang";
        break;
      case "E":
        predikat = "Sangat Kurang";
        break;
      default:
        predikat = "Tidak Ada";
        break;
    }
  }

  // Method untuk mencetak hasil
  void cetakNilai() {
    print("NIM: $nim");
    print("Nama: $nama");
    print("Nilai Akhir: $nilaiAkhir");
    print("Nilai Huruf: $nHuruf");
    print("Predikat: $predikat");
  }
}
