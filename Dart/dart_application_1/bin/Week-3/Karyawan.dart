// Kelas induk Karyawan
class Karyawan {
  String nama;
  int tunjanganAnak;

  Karyawan(this.nama, this.tunjanganAnak);

  void cetakInfo() {
    print('Nama Karyawan: $nama');
    print('Tunjangan Anak: $tunjanganAnak');
  }
}

// Kelas Karyawan Tetap yang merupakan turunan dari Karyawan
class KaryawanTetap extends Karyawan {
  int gajiPokok;

  KaryawanTetap(String nama, int tunjanganAnak, this.gajiPokok)
      : super(nama, tunjanganAnak);

  int totalGaji() {
    return gajiPokok + tunjanganAnak;
  }

  @override
  void cetakInfo() {
    super.cetakInfo();
    print('Gaji Pokok: $gajiPokok');
    print('Total Gaji: ${totalGaji()}');
  }
}

// Kelas Karyawan Kontrak yang merupakan turunan dari Karyawan
class KaryawanKontrak extends Karyawan {
  int upahHarian;
  int jumlahHariMasuk;

  KaryawanKontrak(String nama, int tunjanganAnak, this.upahHarian, this.jumlahHariMasuk)
      : super(nama, tunjanganAnak);

  int totalUpah() {
    return (upahHarian * jumlahHariMasuk) + tunjanganAnak;
  }

  @override
  void cetakInfo() {
    super.cetakInfo();
    print('Upah Harian: $upahHarian');
    print('Jumlah Hari Masuk: $jumlahHariMasuk');
    print('Total Upah: ${totalUpah()}');
  }
}
