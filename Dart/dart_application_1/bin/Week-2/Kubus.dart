class Kubus {
  double sisi;

  Kubus(this.sisi);

  double hitungLuasPermukaan() {
    return 6 * sisi * sisi;
  }

  double hitungVolume() {
    return sisi * sisi * sisi;
  }
}

void main() {
  var kubus = Kubus(3);
  print('Luas Permukaan Kubus: ${kubus.hitungLuasPermukaan()}');
  print('Volume Kubus: ${kubus.hitungVolume()}');
}
