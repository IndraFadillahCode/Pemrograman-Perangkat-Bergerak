import 'dart:convert';

//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_sqlite/form_product.dart';
import 'package:test_sqlite/model/product.dart';

import 'database/db_helper.dart';

DbHelper db = DbHelper();

class ListProdukPage extends StatefulWidget {
  const ListProdukPage({Key? key}) : super(key: key);
  @override
  State<ListProdukPage> createState() => _ListProdukPageState();
}

class _ListProdukPageState extends State<ListProdukPage> {
  List<Product> listProduk = [];

  @override
  void initState() {
//menjalankan fungsi getallProduk saat pertama kali dimuat
    _getAllProduk();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Produk App"),
        ),
      ),
      body: ListView.builder(
          itemCount: listProduk.length,
          itemBuilder: (context, index) {
            Product produk = listProduk[index];
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListTile(
                leading:
                    Image.memory(Base64Decoder().convert(produk.getGambar)),
                title: Text(produk.getNama),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Deskripsi: ${produk.getDeskripsi}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Harga: ${produk.getHarga}"),
                    ),
                  ],
                ),
                trailing: FittedBox(
                  fit: BoxFit.fill,
                  child: Row(
                    children: [
// button edit
                      IconButton(
                          onPressed: () {
                            _openFormEdit(produk);
                          },
                          icon: const Icon(Icons.edit)),
// button hapus
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
//membuat dialog konfirmasi hapus
                          AlertDialog hapus = AlertDialog(
                            title: const Text("Information"),
                            content: Container(
                              height: 100,
                              child: Column(
                                children: [
                                  Text(
                                      "Yakin ingin Menghapus Data ${produk.getNama}")
                                ],
                              ),
                            ),
//terdapat 2 button.
//jika ya maka jalankan _deleteProduk() dan tutup dialog
//jika tidak maka tutup dialog
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    _deleteProduk(produk, index);
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Ya")),
                              TextButton(
                                child: const Text('Tidak'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                          showDialog(
                              context: context, builder: (context) => hapus);
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
//membuat button mengapung di bagian bawah kanan layar
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _openFormCreate();
        },
      ),
    );
  }

//mengambil semua data Produk
  Future<void> _getAllProduk() async {
//list menampung data dari database
    var list = await db.getAllProduk();
//ada perubahanan state
    setState(() {
//hapus data pada listProduk
      listProduk.clear();
//lakukan perulangan pada variabel list
      for (var produk in list!) {
//masukan data ke listProduk
        listProduk.add(Product.fromMap(produk));
      }
    });
    print(listProduk);
  }

//menghapus data Produk
  Future<void> _deleteProduk(Product produk, int position) async {
    await db.deleteProduk(produk.getId);
    setState(() {
      listProduk.removeAt(position);
    });
  }

// membuka halaman tambah Produk
  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FormProduk()));
    if (result == 'save') {
      await _getAllProduk();
    }
  }

//membuka halaman edit Produk
  Future<void> _openFormEdit(Product produk) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => FormProduk(produk: produk)));
    if (result == 'update') {
      await _getAllProduk();
    }
  }
}
