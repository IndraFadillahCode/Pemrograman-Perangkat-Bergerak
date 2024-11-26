import 'package:flutter/material.dart';
import 'product_detail_screen.dart';

class DashboardScreen extends StatelessWidget {
  final List<Map<String, String>> products = [
    {
      "name": "Product 1",
      "description": "Description of Product 1",
      "image": "assets/product1.png"
    },
    {
      "name": "Product 2",
      "description": "Description of Product 2",
      "image": "assets/product2.png"
    },
    // Tambahkan produk lainnya dengan format yang sama
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Image.asset(
                products[index]['image']!,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(products[index]['name']!),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(
                      productName: products[index]['name']!,
                      productDescription: products[index]['description']!,
                      productImage: products[index]['image']!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
