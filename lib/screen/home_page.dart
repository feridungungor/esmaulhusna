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
                      stops: [0.3, 0.7])),
              child: SafeArea(
                top: true,
                bottom: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      DetailPage(true,esmaulhusna: snapshot.data[0])));
                        },
                        child: Text(
                          '${Allah} Allah (c.c)',
                          style: TextStyle(
                            fontSize: 44,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    Container(
                      height: 500,
                      padding: EdgeInsets.only(left: 32),
                      child: Swiper(
                        itemCount: snapshot.data.length,
                        itemWidth: MediaQuery.of(context).size.width - 2 * 64,
                        layout: SwiperLayout.STACK,
                        pagination: SwiperPagination(
                          builder: DotSwiperPaginationBuilder(
                              activeSize: 20, space: 0.5, size: 2),
                        ),
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: 100,
                                  ),
                                  Card(
                                    elevation: 8,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(32)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(32.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 100),
                                          Text(
                                            "${esmalar[index].position} ${esmalar[index + 1].name}",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w900,
                                                color: Color(0Xff47455f)),
                                            textAlign: TextAlign.left,
                                          ),
                                          SizedBox(
                                            height: 32,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Devam',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: secondaryTextColor,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                textAlign: TextAlign.left,
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Icon(
                                                Icons.arrow_forward,
                                                color: secondaryTextColor,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              DetailPage(false,
                                                esmaulhusna:
                                                    snapshot.data[index],
                                              )));
                                },
                                child: Hero(
                                  tag: snapshot.data[index].number,
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      height: 200,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        gradient: RadialGradient(
                                          colors: [
                                            gradientStartColor,
                                            gradientEndColor.withOpacity(.8),
                                          ],
                                          stops: [0.5, 1],
                                        ),
                                        borderRadius: BorderRadius.circular(100),
                                      ),
                                      child: Center(
                                        child: Text(
                                          snapshot.data[index].name,
                                          style: TextStyle(
                                              fontSize: 40, color: Colors.white),
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: navigationColor,
            borderRadius: BorderRadius.vertical(top: Radius.circular(36))),
        padding: EdgeInsets.all(24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: Image.asset('assets/menu_icon.png'),
              onPressed: () {},
            ),
            IconButton(
              icon: Image.asset('assets/search_icon.png'),
              onPressed: () {},
            ),
            IconButton(
              icon: Image.asset('assets/profile_icon.png'),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
