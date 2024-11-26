import 'package:flutter/material.dart';
import 'database_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BarangListPage(),
    );
  }
}

class BarangListPage extends StatefulWidget {
  @override
  _BarangListPageState createState() => _BarangListPageState();
}

class _BarangListPageState extends State<BarangListPage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  late Future<List<Map<String, dynamic>>> _barangList;

  @override
  void initState() {
    super.initState();
    _refreshBarangList();
  }

  void _refreshBarangList() {
    setState(() {
      _barangList = _dbHelper.getAllBarang();
    });
  }

  void _navigateToForm({Map<String, dynamic>? barang}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BarangFormPage(barang: barang),
      ),
    );
    _refreshBarangList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Barang'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _barangList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Belum ada data barang.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final barang = snapshot.data![index];
                return ListTile(
                  title: Text(barang['NmBrg']),
                  subtitle: Text(
                      'Harga Beli: ${barang['HrgBeli']}, Harga Jual: ${barang['HrgJual']}, Stok: ${barang['Stok']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _navigateToForm(barang: barang),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          await _dbHelper.deleteBarang(barang['KdBrg']);
                          _refreshBarangList();
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToForm(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class BarangFormPage extends StatefulWidget {
  final Map<String, dynamic>? barang;

  const BarangFormPage({Key? key, this.barang}) : super(key: key);

  @override
  _BarangFormPageState createState() => _BarangFormPageState();
}

class _BarangFormPageState extends State<BarangFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _kdBrgController = TextEditingController();
  final TextEditingController _nmBrgController = TextEditingController();
  final TextEditingController _hrgBeliController = TextEditingController();
  final TextEditingController _hrgJualController = TextEditingController();
  final TextEditingController _stokController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.barang != null) {
      _kdBrgController.text = widget.barang!['KdBrg'];
      _nmBrgController.text = widget.barang!['NmBrg'];
      _hrgBeliController.text = widget.barang!['HrgBeli'].toString();
      _hrgJualController.text = widget.barang!['HrgJual'].toString();
      _stokController.text = widget.barang!['Stok'].toString();
    }
  }

  void _saveBarang() async {
    if (_formKey.currentState!.validate()) {
      final barang = {
        'KdBrg': _kdBrgController.text,
        'NmBrg': _nmBrgController.text,
        'HrgBeli': int.parse(_hrgBeliController.text),
        'HrgJual': int.parse(_hrgJualController.text),
        'Stok': int.parse(_stokController.text),
      };

      final dbHelper = DatabaseHelper();
      if (widget.barang == null) {
        await dbHelper.insertBarang(barang);
      } else {
        await dbHelper.updateBarang(barang);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Barang')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _kdBrgController,
                decoration: const InputDecoration(labelText: 'Kode Barang'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Kode barang tidak boleh kosong.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nmBrgController,
                decoration: const InputDecoration(labelText: 'Nama Barang'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama barang tidak boleh kosong.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _hrgBeliController,
                decoration: const InputDecoration(labelText: 'Harga Beli'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harga beli tidak boleh kosong.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _hrgJualController,
                decoration: const InputDecoration(labelText: 'Harga Jual'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harga jual tidak boleh kosong.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _stokController,
                decoration: const InputDecoration(labelText: 'Stok'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Stok tidak boleh kosong.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveBarang,
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
