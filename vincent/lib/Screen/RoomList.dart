import 'package:flutter/material.dart';
import 'package:vincent/Widgets/home_widget.dart';

class RoomListScreen extends StatelessWidget {
  const RoomListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hotel List'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              HomeWidget.buildRecentlyBookedCard('https://wallpapertag.com/wallpaper/full/a/7/f/509904-beach-paradise-wallpaper-2560x1600-ipad-retina.jpg','President Hotel', 'Paris, France', 110, 4.5, 4552),
              HomeWidget.buildRecentlyBookedCard('https://wallpapertag.com/wallpaper/full/a/7/f/509904-beach-paradise-wallpaper-2560x1600-ipad-retina.jpg','President Hotel', 'Amsterdam, Netherlands', 90, 4.7, 2592),
              HomeWidget.buildRecentlyBookedCard('https://wallpapertag.com/wallpaper/full/a/7/f/509904-beach-paradise-wallpaper-2560x1600-ipad-retina.jpg','President Hotel', 'Amsterdam, Netherlands', 90, 4.7, 2592),
              HomeWidget.buildRecentlyBookedCard('https://wallpapertag.com/wallpaper/full/a/7/f/509904-beach-paradise-wallpaper-2560x1600-ipad-retina.jpg','President Hotel', 'Amsterdam, Netherlands', 90, 4.7, 2592),
              HomeWidget.buildRecentlyBookedCard('https://wallpapertag.com/wallpaper/full/a/7/f/509904-beach-paradise-wallpaper-2560x1600-ipad-retina.jpg','President Hotel', 'Amsterdam, Netherlands', 90, 4.7, 2592),
              HomeWidget.buildRecentlyBookedCard('https://wallpapertag.com/wallpaper/full/a/7/f/509904-beach-paradise-wallpaper-2560x1600-ipad-retina.jpg','President Hotel', 'Amsterdam, Netherlands', 90, 4.7, 2592),
            ]
          ),
        ),
      )
    );
  }
}