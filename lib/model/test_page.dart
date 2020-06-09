import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutteresmaulhusna/model/husna_model.dart';
import 'package:http/http.dart' as http;

class TestPage extends StatelessWidget {
  Future<List<Data>> _getEsma() async {
    String url =
        "http://api.aladhan.com/asmaAlHusna/1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,991,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print(json.decode(response.body)['data'] as List);
      return (json.decode(response.body)['data'] as List)
          .map((e) => Data.fromJson(e))
          .toList();
    } else {
      throw Exception("Bağlanamadık: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Husna"),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _getEsma(),
        builder: (BuildContext context, AsyncSnapshot<List<Data>> snapshot) {
          if (snapshot.hasData) {
            print("Buraya geldik mi");
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Center(
                    child: Text(
                      snapshot.data[index].name,
                      style: TextStyle(fontSize: 40, fontFamily: 'Arabic'),
                    ),
                  ),
                  subtitle: Text(
                    "Deneme",
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Kufi',
                      fontWeight: FontWeight.bold
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
