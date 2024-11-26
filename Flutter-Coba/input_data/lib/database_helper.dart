import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'barang.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE barang (
            KdBrg TEXT PRIMARY KEY,
            NmBrg TEXT,
            HrgBeli INTEGER,
            HrgJual INTEGER,
            Stok INTEGER
          )
        ''');
      },
    );
  }

  Future<List<Map<String, dynamic>>> getAllBarang() async {
    final db = await database;
    return await db.query('barang');
  }

  Future<void> insertBarang(Map<String, dynamic> barang) async {
    final db = await database;
    await db.insert('barang', barang,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateBarang(Map<String, dynamic> barang) async {
    final db = await database;
    await db.update('barang', barang,
        where: 'KdBrg = ?', whereArgs: [barang['KdBrg']]);
  }

  Future<void> deleteBarang(String kdBrg) async {
    final db = await database;
    await db.delete('barang', where: 'KdBrg = ?', whereArgs: [kdBrg]);
  }
}
