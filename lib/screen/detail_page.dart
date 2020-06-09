import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutteresmaulhusna/model/husna_model.dart';
import 'package:flutteresmaulhusna/screen/constants.dart';
import 'package:flutteresmaulhusna/screen/data.dart';

class DetailPage extends StatelessWidget {

  final Data DataInfo;
  DetailPage({this.DataInfo});

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
                          "DataInfo.name",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 56,
                              color: primaryTextColor,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          'Solar System',
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
                         " DataInfo.number ?? ''",
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 20,
                              color: contentTextColor,
                              fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 32,
                        ),
                        Divider(color: Colors.black38)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 32.0),
                    child: Text(
                      'Galery',
                      style: TextStyle(
                          fontFamily: 'Avenir',
                          fontSize: 25,
                          fontWeight: FontWeight.w300),
                      textAlign: TextAlign.left,
                    ),
                  ),

                ],
              ),
            ),
            Positioned(
              right: -64,
              child: Hero(
//                tag: DataInfo.number,
                tag:2,
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
                       " DataInfo.name",
                        style: TextStyle(
                            fontSize: 40, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 60,
              left: 32,
              child: Text(
               " DataInfo.number.toString()",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Avenir',
                  fontSize: 247,
                  color: primaryTextColor.withOpacity(0.08)
                ),
                textAlign: TextAlign.left,
              ),
            ),
            IconButton(
              icon: Icon( Icons.arrow_back_ios),
              onPressed: (){Navigator.pop(context);},
            ),
          ],
        ),
      ),
    );
  }
}
