import 'Kamera.dart';
import 'Radio.dart';
import 'Telepon.dart';

class Handphone extends Telepon implements Kamera, Radio {
  String gelombang = '';
  double pixel = 0;
  void ambilGambar() {
    print("Gambar terambil...");
  }

  void setGelombang(String gel) {
    this.gelombang = gel;
  }

  void setPixel(double pixel) {
    this.pixel = pixel;
  }

  void setNomor(int no) {
    this.nomer = no;
  }
}
