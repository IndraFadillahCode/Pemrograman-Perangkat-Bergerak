import 'Karyawan.dart';

void main() {
  // Membuat objek Karyawan Tetap
  KaryawanTetap karyawanTetap = KaryawanTetap('Budi', 500000, 5000000);
  print('Informasi Karyawan Tetap:');
  karyawanTetap.cetakInfo();

  print('\n');

  // Membuat objek Karyawan Kontrak
  KaryawanKontrak karyawanKontrak = KaryawanKontrak('Ani', 300000, 200000, 22);
  print('Informasi Karyawan Kontrak:');
  karyawanKontrak.cetakInfo();
}
