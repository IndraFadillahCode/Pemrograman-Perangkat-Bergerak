import 'package:flutter/material.dart';

class FormPembayaran extends StatefulWidget {
  final double totalTransaksi;
  final Map<String, int> selectedItems;

  FormPembayaran({
    required this.totalTransaksi,
    required this.selectedItems,
  });

  @override
  _FormPembayaranState createState() => _FormPembayaranState();
}

class _FormPembayaranState extends State<FormPembayaran> {
  final TextEditingController _jumlahBayarController = TextEditingController();
  double _kembalian = 0;

  void _hitungKembalian() {
    double jumlahBayar = double.tryParse(_jumlahBayarController.text) ?? 0;
    setState(() {
      _kembalian = jumlahBayar - widget.totalTransaksi;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Pembayaran'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(maxWidth: 400),
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Total Transaksi
                Card(
                  elevation: 4,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Total Transaksi',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Rp. ${widget.totalTransaksi.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Input Jumlah Pembayaran
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Jumlah Pembayaran',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        TextField(
                          controller: _jumlahBayarController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 24),
                          decoration: InputDecoration(
                            prefixText: 'Rp. ',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                          onChanged: (value) => _hitungKembalian(),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Kembalian
                Card(
                  elevation: 4,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Kembalian',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Rp. ${_kembalian.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: _kembalian < 0 ? Colors.red : Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),

                // Tombol Selesai
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _kembalian >= 0
                        ? () {
                            Navigator.pop(context);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Selesai',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _jumlahBayarController.dispose();
    super.dispose();
  }
}
