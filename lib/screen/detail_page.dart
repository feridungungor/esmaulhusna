import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutteresmaulhusna/data_esma.dart';
import 'package:flutteresmaulhusna/model/husna_model.dart';
import 'package:flutteresmaulhusna/screen/constants.dart';
import 'dart:math' as math;
class DetailPage extends StatefulWidget {
  Data esmaulhusna;
  bool is_first;

  DetailPage(this.is_first, {@required this.esmaulhusna});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _isUzunAciklama = false;
  bool _isUzunFazilet = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 300,
                  ),
                  Text(
                    widget.is_first
                        ? esmalar[0].name.substring(0, 5)
                        : esmalar[(widget.esmaulhusna.number)].name.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 56,
                      color: primaryTextColor,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    'Celle Celalühü',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 31,
                      color: primaryTextColor,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Divider(color: Colors.black38),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: (){
                      setState(() {
                        _isUzunAciklama = !_isUzunAciklama;
                      });
                    },
                    child: Text(
                      esmalar[(widget.esmaulhusna.number)].uzunAciklama,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 6,
                      style: TextStyle(
                          fontSize: 20,
                          color: contentTextColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Divider(color: Colors.black38),
                  SizedBox(height: 20),
                  Text(
                    "Ebced : ${esmalar[(widget.esmaulhusna.number)].ebced.toString()}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 6,
                    style: TextStyle(
                        fontSize: 20,
                        color: contentTextColor,
                        fontWeight: FontWeight.w500),
                  ),
                  Divider(color: Colors.black38),
                  SizedBox(height: 20),
                  Text(
                    "Zikir Günü : ${esmalar[(widget.esmaulhusna.number)].zikirgunu0} , ${esmalar[(widget.esmaulhusna.number)].zikirgunu1}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 6,
                    style: TextStyle(
                        fontSize: 20,
                        color: contentTextColor,
                        fontWeight: FontWeight.w500),
                  ),
                  Divider(color: Colors.black38),
                  SizedBox(height: 20),
                  InkWell(
                    onTap: (){
                      setState(() {
                        _isUzunFazilet = !_isUzunFazilet;
                      });
                      print("Feridun");
                    },
                    child: Text(
                      "Fazileti : ${esmalar[(widget.esmaulhusna.number)].faziletKisa}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: TextStyle(
                          fontSize: 20,
                          color: contentTextColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Divider(color: Colors.black38),
                ],
              ),
            ),
          ),
          CircleEsmaArabic(),
          EsmaRakami(),
          backIcon(context),
          AnimatedPositioned(
            duration: Duration(milliseconds: 400),
            bottom: _isUzunAciklama || _isUzunFazilet ? -1:-600,
            child: Container(
              height: MediaQuery.of(context).size.height-200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: navigationColor,
                borderRadius: BorderRadius.circular(32)
              ),
              child: Column(
                  children: [
                    SizedBox(height: 10,),
                    Center(
                      child: IconButton(
                        icon: Transform.rotate(
                         angle: -math.pi / 2,
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 40,
                            color: secondaryTextColor.withOpacity(.8),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            if(_isUzunAciklama){_isUzunAciklama = false;}
                            if(_isUzunFazilet){_isUzunFazilet = false;}
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            _isUzunFazilet && !_isUzunAciklama ?
                             esmalar[(widget.esmaulhusna.number)].faziletUzun : esmalar[(widget.esmaulhusna.number)].uzunAciklama,
                            style: TextStyle(
                                fontFamily: 'Kufi',
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),

                      ),
                    ),
                    SizedBox(height: 20,)
                  ],
                )),
          ),
        ],
      ),
      bottomNavigationBar:Container(
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
      )
    ,
    );
  }

  Positioned CircleEsmaArabic() {
    return Positioned(
          right: -10,
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 250,
              width: 250,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    primaryTextColor,
                    Colors.white.withOpacity(.1),
                  ],
                  stops: [0, 1],
                ),
                borderRadius: BorderRadius.circular(1000),
              ),
              child: Center(
                child: Text(
                  widget.is_first ? Allah : widget.esmaulhusna.name,
                  style: TextStyle(
                    fontSize: 70,
                    color: titleTextColor,
                    fontFamily: 'Arabic'
                  ),
                ),
              ),
            ),
          ),
        );
  }
  Positioned EsmaRakami() {
    return Positioned(
          top: 120,
          left: 32,
          child: Text(
            widget.is_first ? Allah : (widget.esmaulhusna.number).toString(),
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 200,
                color: primaryTextColor.withOpacity(0.08)),
            textAlign: TextAlign.left,
          ),
        );
  }
  Positioned backIcon(BuildContext context) {
    return Positioned(
      top: 10,

      child: IconButton(
            icon: Icon(Icons.arrow_back_ios,size: 40,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
    );
  }
}
