class Mhs {
  String nim = '', nama = '', nHuruf = '', predikat = '';
  double nilaiUts = 0,
      nilaiTugas = 0,
      nilaiUas = 0,
      pNilaiUts = 0,
      pNilaiTugas = 0,
      pNilaiUas = 0,
      nilaiAkhir = 0;

  Mhs(String nim, String nama, double nilaiTugas, double nilaiUts,
      double nilaiUas) {
    this.nim = nim;
    this.nama = nama;
    this.nilaiTugas = nilaiTugas;
    this.nilaiUts = nilaiUts;
    this.nilaiUas = nilaiUas;
  }

  void hitungNilai() {
    pNilaiUts = 0.35 * nilaiUts;
    pNilaiTugas = 0.30 * nilaiTugas;
    pNilaiUas = 0.35 * nilaiUas;
    nilaiAkhir = pNilaiUts + pNilaiTugas + pNilaiUas;
  }

  void cetakNilai() {
    print('Nim : $nim');
    print('Nama : $nama');
    print('N. Tugas : $nilaiTugas 30% : $pNilaiTugas');
    print('N. UTS : $nilaiUts 35% : $pNilaiUts');
    print('N. UAS : $nilaiUas 35% : $pNilaiUas');
    print('N. Akhir : $nilaiAkhir');
    nHuruf = getNilaiHuruf(nilaiAkhir);
    print('N. Huruf : $nHuruf');
    predikat = getPredikat(nHuruf);
    print('Predikat : $predikat');
  }

  String getNilaiHuruf(double na) {
    if (na >= 85) {
      nHuruf = 'A';
    } else if (na >= 80) {
      nHuruf = 'AB';
    }
    return nHuruf;
  }

  String getPredikat(String nh) {
    switch (nh) {
      case 'A':
        predikat = 'PERFECT';
        break;
      case 'AB':
        predikat = 'Sangat Baik';
        break;
    }
    return predikat;
  }
}
