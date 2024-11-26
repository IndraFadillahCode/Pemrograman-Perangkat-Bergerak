import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LokasiPage extends StatelessWidget {
  final String mapsUrl = 'https://maps.app.goo.gl/QPJjyjYdFkNkr4qX8';

  Future<void> _openMaps() async {
    if (!await launchUrl(Uri.parse(mapsUrl),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $mapsUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Warung Ajib'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Lokasi Warung',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Jl. Pleburan Barat No.32, Pleburan, Kec. Semarang Sel., Kota Semarang, Jawa Tengah 50241',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _openMaps,
              icon: Icon(Icons.map),
              label: Text('Buka di Google Maps'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
