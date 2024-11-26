import 'dart:convert';
import 'dart:io';

//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'database/db_helper.dart';
import 'model/product.dart';

class FormProduk extends StatefulWidget {
  final Product? produk;
  const FormProduk({super.key, this.produk});
  @override
  State<FormProduk> createState() => _FormProdukState();
}

class _FormProdukState extends State<FormProduk> {
  DbHelper db = DbHelper();
  TextEditingController? nama;
  TextEditingController? deskripsi;
  TextEditingController? harga;
// TextEditingController? gambar;

  final ImagePicker imgpicker = ImagePicker();
  String imagepath = "";
  String imageBase64 = "";
  openImage() async {
    try {
      var pickedFile = await imgpicker.pickImage(source: ImageSource.gallery);
//you can use ImageCourse.camera for Camera capture
      if (pickedFile != null) {
        imagepath = pickedFile.path;
        print(imagepath);
//output /data/user/0/com.example.testapp/cache/image_picker7973898508152261600.jpg

        File imagefile = File(imagepath); //convert Path to File
        Uint8List imagebytes = await imagefile.readAsBytes();
//convert to bytes
        String base64string = base64.encode(
            imagebytes); //convert bytes to base64 string print(base64string);
/* Output:
/9j/4Q0nRXhpZgAATU0AKgAAAAgAFAIgAAQAAAABAAAAAAEAAAQAAAABAAAJ3
wIhAAQAAAABAAAAAAEBAAQAAAABAAAJ5gIiAAQAAAABAAAAAAIjAAQAAAABAAA
AAAIkAAQAAAABAAAAAAIlAAIAAAAgAAAA/gEoAA ... long string output
*/

//Uint8List decodedbytes = base64.decode(base64string);

//decode base64 stirng to bytes

        setState(() {
          imageBase64 = base64string;
        });
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  @override
  void initState() {
    nama = TextEditingController(
        text: widget.produk == null ? '' : widget.produk!.getNama);
    deskripsi = TextEditingController(
        text: widget.produk == null ? '' : widget.produk!.getDeskripsi);
    harga = TextEditingController(
        text: widget.produk == null ? '' : widget.produk!.getHarga);

// gambar = TextEditingController(
// text: widget.produk == null ? '' : widget.produk!.getGambar);
    imageBase64 = widget.produk == null ? '' : widget.produk!.getGambar;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Product'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: nama,
              decoration: InputDecoration(
                  labelText: 'Nama Barang',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: deskripsi,
              decoration: InputDecoration(
                  labelText: 'Deskripsi',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: TextField(
              controller: harga,
              decoration: InputDecoration(
                  labelText: 'Harga',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(20),
                child: Row(children: [
// imagepath != ""?Image.file(File(imagepath)):

// Container(
// child: Text("No Image selected."),
// ),
                  SizedBox(
                    width: 0.6 * MediaQuery.of(context).size.width,
                    child: imageBase64 != ''
                        ? Container(
                            child: Image.memory(
                                Base64Decoder().convert(imageBase64)),
                          )
                        : Container(
                            child: Text(
                              "No Image selected.",
                              style: TextStyle(color: Colors.green[900]),
                            ),
                          ),
                  ),

//open button ----------------
                  IconButton(
                      onPressed: () async {
                        await openImage();
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.upload,
                        color: Colors.green[900],
                      ))
                ])),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.green[900])),
              child: (widget.produk == null)
                  ? const Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    )
                  : const Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
              onPressed: () {
                upsertproduk();
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> upsertproduk() async {
    if (widget.produk != null) {
//update
      await db.updateProduk(Product.fromMap({
        'id': widget.produk!.getId,
        'nama': nama!.text,
        'deskripsi': deskripsi!.text,
        'harga': harga!.text,
        'gambar': imageBase64
      }));
      Navigator.pop(context, 'update');
    } else {
//insert
      await db.saveProduk(
          Product(nama!.text, deskripsi!.text, harga!.text, imageBase64));
      Navigator.pop(context, 'save');
    }
  }
}
