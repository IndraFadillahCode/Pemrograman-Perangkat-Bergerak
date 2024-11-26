import 'dart:math';

class Lingkaran {
  double jariJari;

  Lingkaran(this.jariJari);

  double hitungLuas() {
    return pi * jariJari * jariJari;
  }

  double hitungKeliling() {
    return 2 * pi * jariJari;
  }
}

void main() {
  var lingkaran = Lingkaran(5);
  print('Luas Lingkaran: ${lingkaran.hitungLuas()}');
  print('Keliling Lingkaran: ${lingkaran.hitungKeliling()}');
}
