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
          "${(json.decode(response.body)['data'] as List)
              .length} adet esmaülhüsna getirildi");
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
              child: Column(
                children: [
                  TopBaslik(context, snapshot),
                  CustomSwiper(snapshot, context),
                ],
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



  Widget TopBaslik(BuildContext context, AsyncSnapshot<List<Data>> snapshot) {
    return Container(
      padding: const EdgeInsets.only(top: 25),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (BuildContext context) =>
                  DetailPage(
                    true,
                    esmaulhusna: snapshot.data[0],
                  ),
            ),
          );
        },
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Allah (c.c)',
              style: TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  fontFamily: 'Kufi',
                  letterSpacing: 2
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget CustomSwiper(AsyncSnapshot<List<Data>> snapshot,
      BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Expanded(
      child: Container(
        height: height,
        width : width,
        child: Swiper(
          itemCount: snapshot.data.length,
          itemWidth: MediaQuery
              .of(context)
              .size
              .width - 2 * 64,
          layout: SwiperLayout.STACK,
          itemBuilder: (context, index) {
            print("height ${height}");
            print("width ${width}");
            return Stack(
              children: [
            Container(
              margin: EdgeInsets.only(top: 120),
              height: height/2-20,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
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
                  SizedBox(height: height/5),
                  Text(
                    esmalar[index + 1].name.replaceAll('-', ' ').replaceAll(
                        'İ', 'I').replaceAll('Ğ', 'G'),
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontFamily: 'Arabic'
                    ),
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Center(
                          child: Text(
                            esmalar[index + 1]
                                .kisaAciklama
                                .replaceAll('ş', 's')
                                .replaceAll('İ', 'I'),
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontFamily: 'Arabic',
                              height: 1
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            textAlign: TextAlign.center,

                          ),
                        ),
                  ),
                ],
              ),
            ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                          new MaterialPageRoute(
                            builder: (BuildContext context) => DetailPage(
                              false,
                              esmaulhusna: snapshot.data[index],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: height*1/3.2,
                        width: height*1/3.2,
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
                                ? TextStyle(
                                    fontSize: 35,
                                    color: Colors.white,
                                    fontFamily: 'Arabic')
                                : TextStyle(
                                    fontSize: 70,
                                    color: Colors.white,
                                    fontFamily: 'Arabic'),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  CircleEsmaArabic(AsyncSnapshot<List<Data>> snapshot, int index) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (BuildContext context) =>
                    DetailPage(
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
                ? TextStyle(
                fontSize: 35, color: Colors.white, fontFamily: 'Arabic')
                : TextStyle(
                fontSize: 70, color: Colors.white, fontFamily: 'Arabic'),
          ),
        ),
      ),
    );
  }
  Container CustomBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
          color: navigationColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(36))),
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
//          SvgPicture.asset(assetsIcon[2],height: 45,)
      Icon(Icons.settings,size: 40,color: Colors.blue,),

//          SvgPicture.asset(assetsIcon[1],height: 45,)
      Icon(Icons.settings,size: 40,color: Colors.red,),

//          SvgPicture.asset(assetsIcon[0],height: 45,)
          Icon(Icons.settings,size: 40,color: Colors.black,),
        ],
      ),
    );
  }
}
