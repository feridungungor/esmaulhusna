import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutteresmaulhusna/data_esma.dart';
import 'package:flutteresmaulhusna/model/husna_model.dart';
import 'package:flutteresmaulhusna/screen/constants.dart';

class DetailPage extends StatelessWidget {
  Data esmaulhusna;
  bool is_first;

  DetailPage(this.is_first, {@required this.esmaulhusna});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 300,
                        ),
                        Text(
                          is_first
                              ? esmalar[0].name.substring(0, 5)
                              : esmalar[(esmaulhusna.number)].name.toString(),
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
                        SizedBox(
                          height: 32,
                        ),
                        Text(
                          esmalar[(esmaulhusna.number)].uzunAciklama,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 20,
                              color: contentTextColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: -10,
              child: Hero(
                tag: esmaulhusna.number,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 250,
                    width: 250,
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        colors: [
                          primaryTextColor,
                          Colors.white.withOpacity(.5),
                        ],
                        stops: [0.1, 1],
                      ),
                      borderRadius: BorderRadius.circular(1000),
                    ),
                    child: Center(
                      child: Text(
                        is_first ? Allah : esmaulhusna.name,
                        style: TextStyle(
                          fontSize: 60,
                          color: titleTextColor,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 120,
              left: 32,
              child: Text(
                is_first ? Allah : (esmaulhusna.number).toString(),
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 200,
                    color: primaryTextColor.withOpacity(0.08)),
                textAlign: TextAlign.left,
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
