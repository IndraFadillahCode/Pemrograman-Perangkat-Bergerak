import 'dart:math';

class Segitiga {
  double alas;
  double tinggi;
  double sisiA;
  double sisiB;
  double sisiC;

  Segitiga(this.alas, this.tinggi, this.sisiA, this.sisiB, this.sisiC);

  double hitungLuas() {
    return 0.5 * alas * tinggi;
  }

  double hitungKeliling() {
    return sisiA + sisiB + sisiC;
  }
}

void main() {
  var segitiga = Segitiga(3, 4, 3, 4, 5);
  print('Luas Segitiga: ${segitiga.hitungLuas()}');
  print('Keliling Segitiga: ${segitiga.hitungKeliling()}');
}
