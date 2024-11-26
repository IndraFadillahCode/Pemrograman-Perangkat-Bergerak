import 'dart:convert';

//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_sqlite/list_produk.dart';
import 'package:test_sqlite/payment.dart';
//import 'package:shared_preferences/shared_preferences.dart';

//import 'database/db_helper.dart';
import 'model/product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<Product> listProduct = [];
List<Product> listProductOrder = [];

class _HomeScreenState extends State<HomeScreen> {
  int harga = 0;

  Future<void> _getAllProduk() async {
//list menampung data dari database
    var list = await db.getAllProduk();

//ada perubahanan state
    setState(() {
//hapus data pada listProduct
      listProduct.clear();
//lakukan perulangan pada variabel list
      for (var produk in list!) {
//masukan data ke listProduct
        listProduct.add(Product.fromMap(produk));
      }
    });
    print(listProduct);
    setState(() {});
  }

  void cekHarga() {
    harga = 0;
    for (int i = 0; i < listProductOrder.length; i++) {
      harga += int.parse(listProductOrder[i].getHarga);
    }
  }

  Widget gridContent(
      String nama, String desc, int harga, String img, int index) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(30)),
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          GestureDetector(
              onTap: () {
                listProductOrder.add(listProduct[index]);
                cekHarga();
                setState(() {});
              },
              child: Container(
                width: 100,
                height: 100,
                child: Image.memory(
                  Base64Decoder().convert(img),
                  fit: BoxFit.fill,
                ),
              )),
          SizedBox(
            height: 5,
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        title: Text('Detail Product'),
                        content: Container(height: 300, child: Text(desc)));
                  });
            },
            child: Text(
              nama,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
            ),
          ),
          Text(
            'Rp ${harga.toString()}',
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
// TODO: implement initState
    _getAllProduk();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (listProduct.isEmpty) {
// dummyProduct();
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Call Center'),
                          content: Container(
                              height: 300,
                              child: Text('Hubungi Nomor : 081256737865')),
                        );
                      });
                },
                icon: Icon(
                  Icons.call,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Layanan Pesan'),
                          content: Container(
                              height: 300,
                              child: Text('Pesan pada email kami')),
                        );
                      });
                },
                icon: Icon(
                  Icons.message,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Lokasi Kami'),
                          content: Container(
                              height: 300,
                              child: Text('Lokasi Kami di Semarang Tengah')),
                        );
                      });
                },
                icon: Icon(
                  Icons.location_on,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Pengaturan Akun'),
                          content: Container(
                              height: 300,
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (BuildContext context) {
                                        return ListProdukPage();
                                      }));
                                    },
                                    child: ListTile(
                                      title: Text('Halaman Produk'),
                                      leading: Icon(Icons.trolley),
                                    ),
                                  ),
                                  ListTile(
                                    title: Text('Pengaturan Akun'),
                                    leading: Icon(Icons.person),
                                  ),
                                ],
                              )),
                        );
                      });
                },
                icon: Icon(
                  Icons.change_circle_outlined,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Ubah Password'),
                          content: Container(
                              height: 300, child: Text('Ubah Password anda')),
                        );
                      });
                },
                icon: Icon(
                  Icons.lock,
                  color: Colors.white,
                ))
          ],
          title: Text(
            'Daftar Produk',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
          ),
        ),
        body: SafeArea(
            child: Container(
          height: 0.95 * MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 560,
                  child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, crossAxisSpacing: 20),
                      children: List.generate(
                          listProduct.length,
                          (index) => gridContent(
                              listProduct[index].getNama,
                              listProduct[index].getDeskripsi,
                              int.parse(listProduct[index].getHarga),
                              listProduct[index].getGambar,
                              index))),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 120,
                        child: Column(
                          children: [
                            Text('Total Pesananku'),
                            SizedBox(
                              height: 5,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Payment();
                                }));
                              },
                              child: Text(
                                'Rp ${harga.toString()}',
                                style: TextStyle(fontSize: 18),
                              ),
                            )
                          ],
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Detail Product Transaksi'),
                                    content: Container(
                                        height: 300,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: List.generate(
                                                listProductOrder.length,
                                                (index) => ListTile(
                                                      trailing: IconButton(
                                                          onPressed: () {
                                                            listProductOrder
                                                                .removeAt(
                                                                    index);
                                                            Navigator.pop(
                                                                context);
                                                            cekHarga();
                                                            setState(() {});
                                                          },
                                                          icon: Icon(
                                                              Icons.close)),
                                                      title: Text(
                                                          listProductOrder[
                                                                  index]
                                                              .getNama),
                                                      subtitle: Text(
                                                          listProductOrder[
                                                                  index]
                                                              .getHarga
                                                              .toString()),
                                                    )),
                                          ),
                                        )),
                                  );
                                });
                          },
                          icon: Icon(
                            Icons.menu_book_sharp,
                            size: 35,
                            color: Colors.green[900],
                          )),
                      IconButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return Payment();
                            }));
                          },
                          icon: Icon(
                            Icons.payment,
                            size: 35,
                            color: Colors.green[900],
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        )));
  }
}
