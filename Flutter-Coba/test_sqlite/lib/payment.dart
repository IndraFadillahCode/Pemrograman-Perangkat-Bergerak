//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'main.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  String _username = '';
  int harga = 0;
  @override
  Widget build(BuildContext context) {
    void cekHarga() {
      harga = 0;
      for (int i = 0; i < listProductOrder.length; i++) {
        harga += int.parse(listProductOrder[i].getHarga);
      }
    }

    @override
    void initState() {
      super.initState();
    }

    setState(() {
      _username = sp!.getString('username') ?? "";
      cekHarga();
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'Detail Pembayaran',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            'Pembelian atas nama',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.black54),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            _username,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black54),
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            children: List.generate(
                listProductOrder.length,
                (index) => ListTile(
                      title: Text(
                        listProductOrder[index].getNama,
                        style: TextStyle(fontSize: 14),
                      ),
                      trailing: Text(
                        listProductOrder[index].getHarga.toString(),
                        style: TextStyle(fontSize: 14),
                      ),
                    )),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Total Bayar ',
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Rp $harga',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.green[900])),
              onPressed: () {},
              child: Text(
                'Bayar Barang',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ))
        ],
      ))),
    );
  }
}

