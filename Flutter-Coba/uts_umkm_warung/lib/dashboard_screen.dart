import 'package:flutter/material.dart';
import 'update_user_screen.dart';
import 'package:uts_umkm_warung/payment__screen.dart';
import 'package:uts_umkm_warung/calls_sms_utils.dart';
import 'package:uts_umkm_warung/maps_utils.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Contoh produk yang tersedia di dashboard dengan URL gambar
  final List<Map<String, dynamic>> products = [
    {
      'name': 'Es Teh Ajib',
      'price': 5000,
      'image': 'https://example.com/teh.png',
    },
    {
      'name': 'Lumpia',
      'price': 10000,
      'image': 'https://example.com/lumpia.png',
    },
    {
      'name': 'Jajanan A',
      'price': 3000,
      'image': 'https://example.com/snack.png',
    },
    {
      'name': 'Jajanan B',
      'price': 7000,
      'image': 'https://example.com/snack2.png',
    },
  ];

  // Variabel untuk total harga produk yang dibeli
  int totalHarga = 0;

  // Fungsi untuk menambahkan produk ke total pembelian
  void addToCart(int price) {
    setState(() {
      totalHarga += price;
    });
  }

  // Fungsi untuk mengurangi produk dari total pembelian
  void removeFromCart(int price) {
    if (totalHarga >= price) {
      setState(() {
        totalHarga -= price;
      });
    }
  }

  // Widget untuk menampilkan produk dalam bentuk grid
  Widget buildProductItem(Map<String, dynamic> product) {
    return Card(
      child: Column(
        children: [
          // Mengambil gambar dari link URL
          Image.network(
            product['image'],
            height: 80,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.broken_image, size: 80, color: Colors.grey);
            },
          ),
          SizedBox(height: 10),
          Text(product['name']),
          Text('Rp ${product['price']}'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.add_circle, color: Colors.green),
                onPressed: () => addToCart(product['price']),
              ),
              IconButton(
                icon: Icon(Icons.remove_circle, color: Colors.red),
                onPressed: () => removeFromCart(product['price']),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard Produk'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'Call Center':
                  launchCall('08123456789'); // Nomor contoh
                  break;
                case 'SMS Center':
                  launchSMS('08123456789', 'Halo, saya ingin memesan produk.');
                  break;
                case 'Lokasi/Maps':
                  openMap('Jl. Bandungrejo, Demak');
                  break;
                case 'Update User & Password':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UpdateUserScreen()),
                  );
                  break;
                case 'Pembayaran':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaymentScreen()),
                  );
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(value: 'Call Center', child: Text('Call Center')),
              PopupMenuItem(value: 'SMS Center', child: Text('SMS Center')),
              PopupMenuItem(value: 'Lokasi/Maps', child: Text('Lokasi/Maps')),
              PopupMenuItem(
                  value: 'Update User & Password',
                  child: Text('Update User & Password')),
              PopupMenuItem(value: 'Pembayaran', child: Text('Pembayaran')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return buildProductItem(products[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Total: Rp $totalHarga',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}