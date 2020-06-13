import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutteresmaulhusna/model/husna_model.dart';
import 'package:flutteresmaulhusna/tools/database.dart';
<<<<<<< HEAD
=======
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;
>>>>>>> 442ec8d437a3ab9782ec748b52c01da438f539a0


class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  var dbhelper;
  var datam;
  var list = [];
  @override
  Future<void> initState() {
    super.initState();
    dbhelper = DatabaseHelper();
    if(dbhelper.databaseReady()){
      print("Girdi");
    }else{
      print("Girmedi");
      goster();
    }
//    if(dbhelper.databaseReady()){
//      print("* database hazır");
//    }else{
//      print("* database hazır değil");
//    _getEsma().then((value){
//      ekle(value);
//    });
//  }
  }
  @override
  Widget build(BuildContext context) {

//   goster();
    return Scaffold(
      appBar: AppBar(
        title: Text("Sqflite"),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              Colors.green,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.3, 0.7],
          ),
        ),
        child: ListView.builder(
          itemBuilder: (context,index){
            return ListTile(
                title: Text("")
            );
          },
        ),
      ),
    );
  }

  Future<int> ekle(List<Data> list) async {
    for (Data i in list) {
      datam = Data(
          number: i.number, name: i.name, transliteration: i.transliteration);
      await dbhelper.esmaEkle(datam);
    }
  }

  goster() async{
//    var s = await dbhelper.esmalariGetir();
//    for(var a in s){
//     print(a.runtimeType);
//    }


  }

  Future<List<Data>> _getEsma() async {
    String url =
        "http://api.aladhan.com/asmaAlHusna/1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return (json.decode(response.body)['data'] as List)
          .map((e) => Data.fromJson(e))
          .toList();
    } else {
      throw Exception("Bağlanamadık: ${response.statusCode}");
    }
  }
}
