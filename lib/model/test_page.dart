import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutteresmaulhusna/model/husna_model.dart';
import 'package:flutteresmaulhusna/tools/database.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  var dbhelper;
  var datam;
  List<Data> listofhope = [];


  @override
  Future<void> initState() {
    super.initState();
    dbhelper = DatabaseHelper();
    DOITBRO();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: goster(),
        builder: (BuildContext context, AsyncSnapshot<List<Data>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        snapshot.data[index].number.toString(),
                        style: TextStyle(
                          fontFamily: 'Arabic',
                          fontSize: 60,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 20,),
                      Text(
                        snapshot.data[index].name,
                        style: TextStyle(
                          fontFamily: 'Arabic',
                          fontSize: 60,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  );
                });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
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

  Future<List<Data>> goster() async {
    var myQueryResultSet = await dbhelper.esmalariGetir();
    listofhope =
        (myQueryResultSet as List).map((e) => Data.fromJson(e)).toList();
    return listofhope;
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

  void DOITBRO() async{
    int count = await dbhelper.queryLenght();
    if(count == 0){
      print("Here i am baby");
      _getEsma().then((value){
      ekle(value);
    });
    }
  }
}
