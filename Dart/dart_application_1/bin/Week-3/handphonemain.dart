import 'handphone.dart';

void main() {
  Handphone hp = Handphone();

  hp.setGelombang("FM 101.2");
  print("Gelombang radio : ${hp.gelombang}");
  hp.telpon();
  hp.setPixel(1205);
  hp.ambilGambar();
  hp.setNomor(1554447676);
}
