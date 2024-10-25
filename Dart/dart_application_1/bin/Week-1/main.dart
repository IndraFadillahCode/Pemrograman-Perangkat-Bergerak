import 'mahasiswa.dart';

void main() {
  // Membuat objek Mahasiswa
  Mahasiswa mhs = Mahasiswa("123456789", "Indra Fadillah", 80, 75, 85);

  // Menghitung nilai akhir, nilai huruf, dan predikat
  mhs.hitungNilai();
  mhs.getNilaiHuruf();
  mhs.getPredikat();

  // Mencetak hasil
  mhs.cetakNilai();
}
