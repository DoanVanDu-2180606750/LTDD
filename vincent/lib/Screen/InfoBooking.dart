import 'dart:math';

import 'package:flutter/material.dart';
import 'package:carousel_animations/carousel_animations.dart';
import 'package:qr_flutter/qr_flutter.dart';

class InfoBookingRoom extends StatefulWidget {
  const InfoBookingRoom({super.key});

  @override
  State<InfoBookingRoom> createState() => _InfoBookingRoomState();
}

class _InfoBookingRoomState extends State<InfoBookingRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Room'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            QrImageView(
              data: 'selected',
              version: QrVersions.auto,
              size: 320,
              gapless: false,
            ),
            SizedBox(
              height: 200,
              child: Swiper(
                itemBuilder: (BuildContext context,int index){
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/BeachParadise.png'),
                        fit: BoxFit.cover,
                      )
                    )
                  );
                },
                itemCount: 3,
                pagination: SwiperPagination(),
                control: SwiperControl(),
              ),
            )
          ]
        )
      )
    );
  }
}