import 'package:flutter/material.dart';
class Item {
final String deskripsi, linkGambar;
final int harga;
Item(this.deskripsi, this.linkGambar, this.harga);
}
List<Item> menuImitasi = [
Item("Ayam Goreng Krispi Ajib.", "assets/images/ayam1.jpg", 90000),
Item("Ayam Goreng Ajib.", "assets/images/ayam2.jpg", 80000),
Item("Ayam Bakar sambel mastah.", "assets/images/ayambakar.webp", 70000),
Item("Ayam Bakar kecap manis.", "assets/images/ayambakar1.jfif", 60000),
Item("Ayam Geprek Ajib.", "assets/images/ayamgeprek.jpg", 50000),
Item("Ayam Betutu Ajib.", "assets/images/ayambetutu.jpg", 75000),
];
class HalamanMenu extends StatefulWidget {
const HalamanMenu({super.key});
@override
State<StatefulWidget> createState() => _HalamanMenuState();
}
class _HalamanMenuState extends State<HalamanMenu> {
int hargaAkhir = 0;
@override
Widget build(BuildContext context) {
return Stack(children: [
Padding(
padding: EdgeInsets.all(7),
child: GridView.count(
crossAxisCount: 2,
children: menuImitasi
.map((item) => InkWell(
onTap: () {
setState(() {
hargaAkhir += item.harga;
});
},
child: Column(children: [
SizedBox(

height: 120, child:

Image.asset(item.linkGambar)),

Text(item.deskripsi),
Text("Rp.${item.harga}"),
])))
.toList())),

Positioned(
bottom: 0,
left: 0,
right: 0,
child: Container(
color: Theme.of(context).colorScheme.primaryContainer,
child:
Text("Total: Rp.$hargaAkhir", textAlign:

TextAlign.center))),
]);
}
}