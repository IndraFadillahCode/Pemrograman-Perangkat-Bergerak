import 'Persegi.dart';

void main() {
  Persegi p = new Persegi(2, 10);
  int luas = p.getLuas();
  int kel = p.getKeliling();
  int pj = p.nilai_p;
  int l = p.nilai_l = 9;
  print('P : $pj');
  print('l : $l');
  print('Luas : $luas');
  print('Keliling : $kel');
}
