import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutteresmaulhusna/screen/constants.dart';
import 'package:flutteresmaulhusna/screen/data.dart';

class DetailPage extends StatelessWidget {
  final PlanetInfo planetInfo;

  DetailPage({this.planetInfo});

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
                          planetInfo.name,
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 56,
                              color: primaryTextColor,
                              fontFamily: 'Avenir'),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          'Solar System',
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 31,
                              color: primaryTextColor,
                              fontFamily: 'Avenir'),
                          textAlign: TextAlign.left,
                        ),
                        Divider(color: Colors.black38),
                        SizedBox(
                          height: 32,
                        ),
                        Text(
                          planetInfo.description ?? '',
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontFamily: 'Avenir',
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
                  Container(
                    height: 250,
                    padding: const EdgeInsets.only(left: 32.0),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: planetInfo.images.length,
                      itemBuilder: (context, index) {
                        return Card(
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)
                          ),
                          child: Image.network(planetInfo.images[index]),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              right: -64,
              child: Hero(
                tag: planetInfo.position,
                child: Image.asset(planetInfo.iconImage),
              ),
            ),
            Positioned(
              top: 60,
              left: 32,
              child: Text(
                planetInfo.position.toString(),
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
