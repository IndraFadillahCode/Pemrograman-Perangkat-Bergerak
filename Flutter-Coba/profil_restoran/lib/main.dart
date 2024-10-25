import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Profile',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const RestoProfile(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RestoProfile extends StatelessWidget {
  const RestoProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rm. Sedap Rasa'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar profil restoran dengan border bulat
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    'https://assets.promediateknologi.id/crop/0x0:0x0/750x500/webp/photo/2023/01/30/3047303522.jpg',
                    width: 180,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Row ikon email, map, dan telepon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  ProfileIcon(icon: Icons.email, label: 'Email'),
                  ProfileIcon(icon: Icons.map, label: 'Map'),
                  ProfileIcon(icon: Icons.phone, label: 'Call'),
                ],
              ),
              const SizedBox(height: 30),

              // Deskripsi Restoran
              const SectionTitle(title: 'Deskripsi'),
              const SizedBox(height: 8),
              const Text(
                'Restoran ini menawarkan berbagai hidangan khas dengan cita rasa otentik dan harga terjangkau. '
                'Suasana nyaman dengan pelayanan ramah menjadikan tempat ini favorit untuk keluarga dan teman.',
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 20),

              // List Menu
              const SectionTitle(title: 'List Menu'),
              const SizedBox(height: 8),
              Column(
                children: const [
                  MenuItem(name: 'Nasi Goreng'),
                  MenuItem(name: 'Mie Ayam'),
                  MenuItem(name: 'Sate Ayam'),
                  MenuItem(name: 'Es Teh Manis'),
                ],
              ),
              const SizedBox(height: 20),

              // Alamat Restoran
              const SectionTitle(title: 'Alamat'),
              const SizedBox(height: 8),
              const Text(
                'Jl. Raya No. 123, Jakarta',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),

              // Jam Buka Restoran
              const SectionTitle(title: 'Jam Buka'),
              const SizedBox(height: 8),
              const Text(
                'Senin - Jumat: 08.00 - 21.00\nSabtu - Minggu: 10.00 - 23.00',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget untuk ikon profil dengan label
class ProfileIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const ProfileIcon({required this.icon, required this.label, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Colors.teal),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ],
    );
  }
}

// Widget untuk judul bagian (section title)
class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.teal,
      ),
    );
  }
}

// Widget untuk item menu
class MenuItem extends StatelessWidget {
  final String name;

  const MenuItem({required this.name, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.restaurant_menu, color: Colors.teal),
      title: Text(name, style: const TextStyle(fontSize: 16)),
    );
  }
}
