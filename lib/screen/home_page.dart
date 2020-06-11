import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutteresmaulhusna/data_esma.dart';
import 'package:flutteresmaulhusna/model/husna_model.dart';
import 'package:flutteresmaulhusna/screen/constants.dart';
import 'package:flutteresmaulhusna/screen/detail_page.dart';
import 'package:flutteresmaulhusna/screen/test_two.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Data>> _getEsma() async {
    String url =
        "http://api.aladhan.com/asmaAlHusna/1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      print(
          "${(json.decode(response.body)['data'] as List).length} adet esmaülhüsna getirildi");
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
      backgroundColor: gradientEndColor,
      body: FutureBuilder(
        future: _getEsma(),
        builder: (BuildContext context, AsyncSnapshot<List<Data>> snapshot) {
          if (snapshot.hasData) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    gradientStartColor,
                    gradientEndColor,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.3, 0.7],
                ),
              ),
              child: SafeArea(
                top: true,
                bottom: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TopBaslik(context, snapshot),
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        padding: EdgeInsets.only(left: 32),
                        child: CustomSwiper(snapshot, context),
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }

  Container CustomBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
          color: navigationColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(36))),
      padding: EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.apps,
            size: 35,
            color: secondaryTextColor,
          ),
          Icon(
            Icons.search,
            size: 35,
          ),
          Icon(
            Icons.person,
            size: 35,
          )
        ],
      ),
    );
  }

  Widget TopBaslik(BuildContext context, AsyncSnapshot<List<Data>> snapshot) {
    return Container(
      padding: const EdgeInsets.only(top: 25),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (BuildContext context) => DetailPage(
                true,
                esmaulhusna: snapshot.data[0],
              ),
            ),
          );
        },
        child: Center(
          child: Text(
            'Allah (c.c)',
            style: TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              fontFamily: 'Arabic'
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ),
    );
  }

  Swiper CustomSwiper(
      AsyncSnapshot<List<Data>> snapshot, BuildContext context) {
    return Swiper(
      itemCount: snapshot.data.length,
      itemWidth: MediaQuery.of(context).size.width - 2 * 64,
      layout: SwiperLayout.STACK,
//      pagination: SwiperPagination(
//        builder: DotSwiperPaginationBuilder(
//            activeColor: gradientStartColor.withOpacity(.5),
//            activeSize: 20,
//            space: 0.5,
//            size: 2),
//      ),
      itemBuilder: (context, index) {
        return Stack(
          overflow: Overflow.visible,
          children: [
            Container(
              margin: EdgeInsets.only(top: 125),
              height: 400,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      gradientStartColor,
                      gradientEndColor,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.1, 0.7],
                  ),
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black38,
                        offset: Offset(1, 6),
                        blurRadius: 10),
                  ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 145),
                  Text(
                    esmalar[index + 1].name.replaceAll('-', ' ').replaceAll('İ', 'I').replaceAll('Ğ', 'G'),
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontFamily: 'Arabic'
                    ),
                  ),
                  SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Center(
                        child: Text(
                      esmalar[index + 1].kisaAciklama.replaceAll('ş', 's').replaceAll('İ', 'I'),
                      style: TextStyle(fontSize: 25, color: Colors.white,
                      fontFamily: 'Kufi'),
                    )),
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Detay",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Kufi'
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 25,
                      ),
                      SizedBox(width: 20,),
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              left: 20,
                child: CircleEsmaArabic(snapshot, index))
          ],
        );
      },
    );
  }

   CircleEsmaArabic(AsyncSnapshot<List<Data>> snapshot, int index) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) => DetailPage(
                  false,
                  esmaulhusna: snapshot.data[index],
                )));
      },
      child: Container(
        height: 250,
        width: 250,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              gradientStartColor,
              gradientEndColor.withOpacity(.8),
            ],
            stops: [0.5, 1],
          ),
          borderRadius: BorderRadius.circular(1000),
        ),
        child: Center(
          child: Text(
            snapshot.data[index].name,
            style: snapshot.data[index].number == 85
                ? TextStyle(fontSize: 35, color: Colors.white,fontFamily: 'Arabic')
                : TextStyle(fontSize: 70, color: Colors.white,fontFamily: 'Arabic'),
          ),
        ),
      ),
    );
  }
}
