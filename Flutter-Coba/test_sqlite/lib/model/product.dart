class Product {
  int _id = 0;
  String _nama = "";
  String _deskripsi = "";
  String _harga = "";
  String _gambar = "";

// konstruktor versi 1
  Product(this._nama, this._deskripsi, this._harga, this._gambar);
// konstruktor versi 2: konversi dari Map ke Product
  Product.fromMap(Map<String, dynamic> map) {
    _id = map['id'];
    _nama = map['nama'];
    _deskripsi = map['deskripsi'];
    _harga = map['harga'];
    _gambar = map['gambar'];
  }

//getter dan setter (mengambil dan mengisi data kedalam object)

// getter
  int get getId => _id;
  String get getNama => _nama;
  String get getDeskripsi => _deskripsi;
  String get getHarga => _harga;
  String get getGambar => _gambar;
// setter

  set setNama(String value) {
    _nama = value;
  }

  set setDeskripsi(String value) {
    _deskripsi = value;
  }

  set setHarga(String value) {
    _harga = value;
  }

  set setGambar(String value) {
    _gambar = value;
  }

// konversi dari Product ke Map
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
// map['id'] = _id;
    map['nama'] = _nama;
    map['deskripsi'] = _deskripsi;
    map['harga'] = _harga;
    map['gambar'] = _gambar;
    return map;
  }
}
