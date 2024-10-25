import 'package:flutter/material.dart';
import 'package:nilai_ppb_flutter/mahasiswa.dart';

class FormulirNilai extends StatefulWidget {
  const FormulirNilai({super.key});

  @override
  State<StatefulWidget> createState() => _FormulirNilaiState();
}

class _FormulirNilaiState extends State<FormulirNilai> {
  final namaController = TextEditingController();
  final nimController = TextEditingController();
  final tugasController = TextEditingController.fromValue(TextEditingValue(text: 0.toString()));
  final utsController = TextEditingController.fromValue(TextEditingValue(text: 0.toString()));
  final uasController = TextEditingController.fromValue(TextEditingValue(text: 0.toString()));

  Mahasiswa? mhs;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Input for Nama
        TextField(
          controller: namaController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Nama Mahasiswa",
          ),
        ),
        const SizedBox(height: 7),

        // Input for NIM
        TextField(
          controller: nimController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "NIM Mahasiswa",
          ),
        ),
        const SizedBox(height: 7),

        // Input for Nilai Tugas
        TextField(
          controller: tugasController,
          onChanged: (value) {
            updateNilai("tugas", double.tryParse(value) ?? 0.0);
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Nilai Tugas",
          ),
        ),
        const SizedBox(height: 7),

        // Input for Nilai UTS
        TextField(
          controller: utsController,
          onChanged: (value) {
            updateNilai("uts", double.tryParse(value) ?? 0.0);
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Nilai UTS",
          ),
        ),
        const SizedBox(height: 7),

        // Input for Nilai UAS
        TextField(
          controller: uasController,
          onChanged: (value) {
            updateNilai("uas", double.tryParse(value) ?? 0.0);
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Nilai UAS",
          ),
        ),
        const SizedBox(height: 7),

        // Display the final results
        if (mhs != null) ...[
          Text("Nama: ${mhs!.nama}", style: Theme.of(context).textTheme.bodyLarge),
          Text("NIM: ${mhs!.nim}", style: Theme.of(context).textTheme.bodyLarge),
          Text("Nilai Akhir: ${mhs!.nilaiAkhir}", style: Theme.of(context).textTheme.bodyLarge),
          Text("Nilai Huruf: ${mhs!.nilaiHuruf}", style: Theme.of(context).textTheme.bodyLarge),
          Text("Predikat: ${mhs!.predikat}", style: Theme.of(context).textTheme.bodyLarge),
        ]
      ],
    );
  }

  void updateNilai(String key, double value) {
    setState(() {
      if (mhs == null) {
        mhs = Mahasiswa(namaController.text, nimController.text,
                        double.tryParse(tugasController.text) ?? 0.0,
                        double.tryParse(utsController.text) ?? 0.0,
                        double.tryParse(uasController.text) ?? 0.0);
      }

      switch (key) {
        case "tugas":
          mhs!.nilaiTugas = value;
          break;
        case "uts":
          mhs!.nilaiUts = value;
          break;
        case "uas":
          mhs!.nilaiUas = value;
          break;
      }
      mhs!.hitungNilai();
    });
  }
}
