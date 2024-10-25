import 'dart:math';

void main() {
  // Persegi
  double sisi = 5;
  double luasPersegi = sisi * sisi;
  double kelilingPersegi = 4 * sisi;
  print("Luas Persegi: $luasPersegi");
  print("Keliling Persegi: $kelilingPersegi");

  // Lingkaran
  double jariJari = 7;
  double luasLingkaran = pi * jariJari * jariJari;
  double kelilingLingkaran = 2 * pi * jariJari;
  print("\nLuas Lingkaran: $luasLingkaran");
  print("Keliling Lingkaran: $kelilingLingkaran");

  // Kubus
  double panjangSisiKubus = 4;
  double luasPermukaanKubus = 6 * (panjangSisiKubus * panjangSisiKubus);
  double volumeKubus = panjangSisiKubus * panjangSisiKubus * panjangSisiKubus;
  print("\nLuas Permukaan Kubus: $luasPermukaanKubus");
  print("Volume Kubus: $volumeKubus");
}
