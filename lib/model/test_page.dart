import 'package:flutter/material.dart';
import 'package:flutteresmaulhusna/models/personel.dart';
import 'package:flutteresmaulhusna/tools/database.dart';


class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  var dbhelper;

  var per;

  @override
  void initState() {
    super.initState();
    dbhelper = DatabaseHelper();
    ekle();
    guncelle();
    sil();
  }
  @override
  Widget build(BuildContext context) {

    goster();
    return Scaffold(
      appBar: AppBar(
        title: Text("Sqflite"),
        centerTitle: true,
      ),
      body: Center(
        child: Text("Data Base"),
      ),
    );
  }

  Future<int> ekle() async {
    per=Personel(isim: 'Feridun' , aktif:  true);
    await dbhelper.personelEkle(per);
  }

  goster() async{
    var s = await dbhelper.personelleriGetir();
    print(s);
  }

  guncelle () async {
    per.isim = 'Hasan';
    await dbhelper.personelGuncelle(per);
  }

  sil() async{
    await dbhelper.personelSil(1);
  }
}
