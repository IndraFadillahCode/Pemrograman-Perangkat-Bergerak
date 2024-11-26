import 'package:flutter/material.dart';
import 'menu.dart';

//ignore: must_be_immutable
class PesanPage extends StatefulWidget {
  PesanPage({super.key, required this.pesananMenu});
  Menu pesananMenu;

  @override
  State<StatefulWidget> createState() => _PesanPage(pesananMenu: pesananMenu);
}

class _PesanPage extends State<PesanPage> {
  _PesanPage({required this.pesananMenu});
  Menu pesananMenu;
  int total = 0;
  int curJml = 0;
  TextEditingController jmlCtrl = TextEditingController();
  bool isImageTapped = false;

  @override
  void initState() {
    super.initState();
    jmlCtrl.text = '0';
  }

  void changeJml(String op) {
    curJml = int.tryParse(jmlCtrl.text.toString()) ?? 0;
    if (op == '+') {
      curJml++;
    } else if (op == '-' && curJml > 0) {
      curJml--;
    }
    jmlCtrl.text = curJml.toString();
    setState(() {
      total = curJml * pesananMenu.harga;
    });
  }

  void _handleImageTap() {
    setState(() {
      if (!isImageTapped) {
        curJml++;
        jmlCtrl.text = curJml.toString();
        total = curJml * pesananMenu.harga;
        isImageTapped = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size
    final screenSize = MediaQuery.of(context).size;
    final double imageSize = screenSize.width * 0.6; // 60% of screen width

    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Pesanan"),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenSize.width * 0.05, // 5% padding on sides
              vertical: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Hero(
                    tag: 'menu-${pesananMenu.Nama}',
                    child: GestureDetector(
                      onTap: _handleImageTap,
                      child: Container(
                        width: imageSize,
                        height: imageSize,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              spreadRadius: 1,
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'assets/images/${pesananMenu.gambar}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenSize.height * 0.03),
                Text(
                  pesananMenu.Nama,
                  style: TextStyle(
                    fontSize: screenSize.width * 0.06,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenSize.height * 0.015),
                Text(
                  pesananMenu.Deskripsi,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenSize.width * 0.04,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: screenSize.height * 0.015),
                Text(
                  "Rp. ${pesananMenu.harga.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenSize.width * 0.05,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: screenSize.height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Material(
                      elevation: 4,
                      shape: CircleBorder(),
                      child: Ink(
                        decoration: ShapeDecoration(
                          color: Colors.pink,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          onPressed: () => changeJml('-'),
                          icon: Icon(Icons.remove),
                          color: Colors.white,
                          iconSize: screenSize.width * 0.06,
                        ),
                      ),
                    ),
                    Container(
                      width: screenSize.width * 0.2,
                      child: TextField(
                        controller: jmlCtrl,
                        textAlign: TextAlign.center,
                        readOnly: true,
                        style: TextStyle(
                          fontSize: screenSize.width * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                    ),
                    Material(
                      elevation: 4,
                      shape: CircleBorder(),
                      child: Ink(
                        decoration: ShapeDecoration(
                          color: Colors.green,
                          shape: CircleBorder(),
                        ),
                        child: IconButton(
                          onPressed: () => changeJml('+'),
                          icon: Icon(Icons.add),
                          color: Colors.white,
                          iconSize: screenSize.width * 0.06,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenSize.height * 0.03),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: screenSize.height * 0.02,
                    horizontal: screenSize.width * 0.04,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    "Total: Rp. ${total.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: screenSize.width * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: screenSize.height * 0.03),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, {
                      'jumlah': curJml,
                      'total': total,
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      vertical: screenSize.height * 0.02,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 4,
                  ),
                  child: Text(
                    'Tambah ke Keranjang',
                    style: TextStyle(
                      fontSize: screenSize.width * 0.045,
                      fontWeight: FontWeight.bold,
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
}
