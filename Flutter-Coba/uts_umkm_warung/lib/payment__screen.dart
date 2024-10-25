import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pembayaran')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Lakukan proses pembayaran
            Navigator.pop(context);
          },
          child: Text('Bayar Sekarang'),
        ),
      ),
    );
  }
}
