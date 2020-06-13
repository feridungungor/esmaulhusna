import 'dart:io';
import 'package:flutteresmaulhusna/model/husna_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String _esmaulhusnaTablo = 'esmaulhusna';
  String _sutunName = 'name';
  String _sutunMana = 'transliteration';
  String _sutunId = 'number';



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
    String path = join(klasor.path, 'esmaulhusna.db');
    var esmaulhusnaDB =
        await openDatabase(path, version: 1, onCreate: _creatTablo);
    return esmaulhusnaDB;
  }

  Future _creatTablo(Database db, int versiyon) async {
    await db.execute(
        "CREATE TABLE $_esmaulhusnaTablo  ($_sutunId , $_sutunName TEXT, $_sutunMana TEXT )");
  }

  Future<int> esmaEkle(Data esma) async{
    var db = await getDatabase();
    var sonuc = await db.insert(_esmaulhusnaTablo, esma.toJson());
    return sonuc;
  }


  Future<List<Map<String,dynamic>>>esmalariGetir() async {
    var db = await getDatabase();
    var sonuc = await db.query(_esmaulhusnaTablo);
    return sonuc;
  }


 bool databaseReady(){
    if(_database == null){return false;}
    else{return true;}
 }
}
