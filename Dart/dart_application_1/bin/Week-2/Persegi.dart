class Persegi {
  int p = 0, l = 0;
  int luas = 0;
  Persegi(int p, int l) {
    this.p = p;
    this.l = l;
  }
  int get nilai_p {
    return p;
  }

  void set nilai_l(int l) {
    this.l = l;
  }

  int getLuas() {
    return p * l;
  }

  int getKeliling() {
    return 2 * (p + 1);
  }
}
