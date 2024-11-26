import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'halaman_user.dart';
import 'dart:convert';
import 'menu.dart';
import 'menu_pesan.dart';
import 'update_user.dart';
import 'form_pembayaran.dart';
import 'call_center.dart';
import 'sms_center.dart';
import 'lokasi.dart';

class HalamanDashboard extends StatefulWidget {
  HalamanDashboard({super.key});

  @override
  State<HalamanDashboard> createState() => _HalamanDashboardState();
}

class _HalamanDashboardState extends State<HalamanDashboard> {
  List<Menu> listMenu = [];
  Map<String, int> selectedItems = {};
  double totalHarga = 0.0;
  String _username = '';
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    dummyMenu();
    _loadUserData();
  }

  // Existing methods remain the same
  void _loadUserData() async {
    _prefs = await SharedPreferences.getInstance();
    String? userData = _prefs.getString('user');
    if (userData != null) {
      Map<String, dynamic> user = json.decode(userData);
      setState(() {
        _username = user.keys.first;
      });
    }
  }

  void dummyMenu() {
    listMenu.add(Menu(
        Nama: 'Es Teh',
        Deskripsi:
            "Cocok untuk suasana panas neraka semarang",
        harga: 3000,
        gambar: 'esteh.jpeg'));
    listMenu.add(Menu(
        Nama: "Lumpia Goreng",
        Deskripsi:
            "Lumpia khas semarang",
        harga: 20000,
        gambar: 'lumpia.jpeg'));
    listMenu.add(Menu(
        Nama: "Mendoan",
        Deskripsi:
            "Mendoan Mantap MURMER!!",
        harga: 20000,
        gambar: 'mendoan.jpeg'));
    listMenu.add(Menu(
        Nama: "Risol Mayo",
        Deskripsi:
            "Risol Mayo Khas kantin semarang",
        harga: 16000,
        gambar: 'risolmayo.jpeg'));
    listMenu.add(Menu(
        Nama: "Tahu Bulat",
        Deskripsi:
            "Tahu Yang Bulat",
        harga: 10000,
        gambar: 'tahubulat.jpeg'));
  }

  void _updateTotal(Menu menu) {
    setState(() {
      if (selectedItems.containsKey(menu.Nama)) {
        selectedItems[menu.Nama] = selectedItems[menu.Nama]! + 1;
      } else {
        selectedItems[menu.Nama] = 1;
      }
      totalHarga += menu.harga.toDouble();
    });
  }

  void _cancelTotal(Menu menu) {
    setState(() {
      if (selectedItems.containsKey(menu.Nama)) {
        if (selectedItems[menu.Nama]! > 1) {
          selectedItems[menu.Nama] = selectedItems[menu.Nama]! - 1;
        } else {
          selectedItems.remove(menu.Nama);
        }
        totalHarga -= menu.harga.toDouble();
        if (totalHarga < 0) totalHarga = 0;
      }
    });
  }

  Widget _buildMenuItem(Menu menu, double screenWidth) {
    // Calculate responsive dimensions
    final isPhone = screenWidth < 600;
    final imageHeight = isPhone ? 120.0 : 180.0;
    final double fontSize = isPhone ? 14 : 16;
    final double descFontSize = isPhone ? 12 : 14;
    final double priceFontSize = isPhone ? 13 : 15;
    final double buttonFontSize = isPhone ? 12 : 14;
    final double cardPadding = isPhone ? 8.0 : 12.0;

    return Card(
      elevation: isPhone ? 1 : 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Padding(
        padding: EdgeInsets.all(cardPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: GestureDetector(
                onTap: () => _updateTotal(menu),
                onDoubleTap: () => _cancelTotal(menu),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/images/${menu.gambar}',
                      height: imageHeight,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: isPhone ? 8 : 12),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    menu.Nama,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: fontSize,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Expanded(
                    child: Text(
                      menu.Deskripsi,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: descFontSize,
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    "Rp ${menu.harga.toStringAsFixed(0)}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: priceFontSize,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: isPhone ? 8 : 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  vertical: isPhone ? 8 : 12,
                  horizontal: isPhone ? 16 : 24,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                "Pesan",
                style: TextStyle(fontSize: buttonFontSize),
              ),
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PesanPage(pesananMenu: menu),
                  ),
                );
                if (result != null) {
                  setState(() {
                    int jumlah = result['jumlah'];
                    double total = result['total'].toDouble();
                    if (jumlah > 0) {
                      if (selectedItems.containsKey(menu.Nama)) {
                        selectedItems[menu.Nama] =
                            selectedItems[menu.Nama]! + jumlah;
                      } else {
                        selectedItems[menu.Nama] = jumlah;
                      }
                      totalHarga += total;
                    }
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomSection() {
    final screenWidth = MediaQuery.of(context).size.width;
    final isPhone = screenWidth < 600;

    return Container(
      padding: EdgeInsets.all(isPhone ? 12.0 : 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: Offset(0, -2),
            blurRadius: 6,
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
    if (totalHarga > 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FormPembayaran(
            totalTransaksi: totalHarga,
            selectedItems: selectedItems,
          ),
        ),
      ).then((_) {
        // Reset total harga dan selectedItems setelah kembali dari FormPembayaran
        setState(() {
          totalHarga = 0.0;
          selectedItems.clear();
        });
      });
    }
  },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: isPhone ? 8 : 12,
                  horizontal: isPhone ? 12 : 16,
                ),
                decoration: BoxDecoration(
                  color: totalHarga > 0
                      ? Theme.of(context).primaryColor.withOpacity(0.1)
                      : Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Pesanan:",
                      style: TextStyle(
                        fontSize: isPhone ? 14 : 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Rp ${totalHarga.toStringAsFixed(0)}",
                      style: TextStyle(
                        fontSize: isPhone ? 16 : 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (selectedItems.isNotEmpty) ...[
              SizedBox(height: isPhone ? 8 : 12),
              Container(
                padding: EdgeInsets.all(isPhone ? 8 : 12),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    ...selectedItems.keys.map((key) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                key,
                                style: TextStyle(
                                  fontSize: isPhone ? 12 : 14,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              "x${selectedItems[key]!}",
                              style: TextStyle(
                                fontSize: isPhone ? 12 : 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],
            SizedBox(height: isPhone ? 4 : 8),
            Text(
              "Ketuk 2x pada gambar untuk menghapus pesanan",
              style: TextStyle(
                fontSize: isPhone ? 11 : 12,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isPhone = screenWidth < 600;

    // Responsive grid settings
    int crossAxisCount;
    double childAspectRatio;

    if (screenWidth < 400) {
      crossAxisCount = 1;
      childAspectRatio = 0.8;
    } else if (screenWidth < 600) {
      crossAxisCount = 2;
      childAspectRatio = 0.7;
    } else if (screenWidth < 1200) {
      crossAxisCount = 3;
      childAspectRatio = 0.85;
    } else {
      crossAxisCount = 4;
      childAspectRatio = 0.9;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert,
              size: isPhone ? 24 : 28,
            ),
            offset: Offset(0, isPhone ? 40 : 50),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'Call Center',
                height: isPhone ? 40 : 48,
                child: Row(
                  children: [
                    Icon(Icons.phone, size: isPhone ? 20 : 24),
                    SizedBox(width: 8),
                    Text(
                      'Call Center',
                      style: TextStyle(fontSize: isPhone ? 14 : 16),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'SMS Center',
                height: isPhone ? 40 : 48,
                child: Row(
                  children: [
                    Icon(Icons.message, size: isPhone ? 20 : 24),
                    SizedBox(width: 8),
                    Text(
                      'SMS Center',
                      style: TextStyle(fontSize: isPhone ? 14 : 16),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'Lokasi/Maps',
                height: isPhone ? 40 : 48,
                child: Row(
                  children: [
                    Icon(Icons.location_on, size: isPhone ? 20 : 24),
                    SizedBox(width: 8),
                    Text(
                      'Lokasi/Maps',
                      style: TextStyle(fontSize: isPhone ? 14 : 16),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'Update User & Password',
                height: isPhone ? 40 : 48,
                child: Row(
                  children: [
                    Icon(Icons.person, size: isPhone ? 20 : 24),
                    SizedBox(width: 8),
                    Text(
                      'Update User & Password',
                      style: TextStyle(fontSize: isPhone ? 14 : 16),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'Logout',
                child: Text('Logout'),
              ),
            ],
            onSelected: (String result) async {
              switch (result) {
                case 'Call Center':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CallCenterPage()),
                  );
                  break;
                case 'SMS Center':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SMSCenterPage()),
                  );
                  break;
                case 'Lokasi/Maps':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LokasiPage()),
                  );
                  break;
                case 'Update User & Password':
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            UpdateUserPage(username: _username)),
                  ).then((_) => _loadUserData());
                  break;
                case 'Logout':
                  final spInstance = await SharedPreferences.getInstance();
                  // Navigasi ke HalamanUser
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HalamanUser(spInstance)),
                  );
                  break;
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(isPhone ? 12.0 : 16.0),
            child: Row(
              children: [
                Icon(
                  Icons.person_outline,
                  size: isPhone ? 24 : 28,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(width: 8),
                Text(
                  'Selamat datang, $_username',
                  style: TextStyle(
                    fontSize: isPhone ? 16 : 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(isPhone ? 8.0 : 16.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: childAspectRatio,
                crossAxisSpacing: isPhone ? 8.0 : 16.0,
                mainAxisSpacing: isPhone ? 8.0 : 16.0,
              ),
              itemCount: listMenu.length,
              itemBuilder: (context, index) {
                return _buildMenuItem(listMenu[index], screenWidth);
              },
            ),
          ),
          _buildBottomSection(),
        ],
      ),
    );
  }
}