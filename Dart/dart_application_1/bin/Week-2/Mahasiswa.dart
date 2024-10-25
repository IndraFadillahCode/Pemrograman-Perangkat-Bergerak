void main() {
  Mahasiswa mhs = new Mahasiswa();
  mhs.nim = 'A11.2022.14186';
  mhs.nama = 'Indra';
  mhs.IPK = 3.8;
  mhs.view();
}

class Mahasiswa {
  String nim = "", nama = "";
  double IPK = 0;
  Mahasiswa() {
    print('~~Data Mahasiswa~~');
  }
  void view() {
    print('Nim : $nim');
    print('Nama : $nama');
    print('IPK : $IPK');
  }
}
