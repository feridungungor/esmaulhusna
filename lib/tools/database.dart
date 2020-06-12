import 'dart:io';
import 'package:flutteresmaulhusna/models/personel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;
  String _personelTablo = 'personel';
  String _sutunId = 'id';
  String _sutunIsim = 'isim';
  String _sutunAktif = 'aktif';

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._internal();
      return _databaseHelper;
    } else {
      return _databaseHelper;
    }
  }

  Future<Database> getDatabase() async {
    if (_database == null) {
      _database = await initDB();
      return _database;
    } else {
      return _database;
    }
  }

  initDB() async {
    Directory klasor = await getApplicationDocumentsDirectory();
    String path = join(klasor.path, 'personel.db');
    var personelDB =
        await openDatabase(path, version: 1, onCreate: _creatTablo);
    return personelDB;
  }

  Future _creatTablo(Database db, int versiyon) async {
    await db.execute(
        "CREATE TABLE $_personelTablo ($_sutunId INTEGER PRIMARY KEY AUTOINCREMENT, $_sutunIsim TEXT, $_sutunAktif TEXT )");
  }

  Future<int> personelEkle(Personel per) async{
    var db = await getDatabase();
    var sonuc = await db.insert(_personelTablo, per.toMap());
    return sonuc;
  }


  Future<List<Map<String,dynamic>>>personelleriGetir() async {
    var db = await getDatabase();
    var sonuc = await db.query(_personelTablo, orderBy: '$_sutunId DESC');
    return sonuc;
  }

  Future<int> personeliGuncelle(Personel per) async {
    var db = await getDatabase();
    var sonuc = await db.update(_personelTablo, per.toMap(), where: '$_sutunId', whereArgs: [per.id]);
    return sonuc;
  }

  Future<int> personelSil(int id) async{
    var db = await getDatabase();

    var sonuc = await db.delete(_personelTablo,where: '$_sutunId = ?', whereArgs: [id]);
    return sonuc;
  }

}
