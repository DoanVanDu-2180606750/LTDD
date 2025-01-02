import 'package:flutter/material.dart';
import 'package:vincent/Screen/ListHome.dart';
import 'package:vincent/Widgets/home_widget.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

   bool _isSelected = true;


  void check() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vincent', style: TextStyle(color: Colors.black, fontSize: 25)),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_active_outlined, color: Colors.black, size: 30),
            onPressed: () {

            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hello, Ngân 👋', style: TextStyle(fontSize: 30, color: Colors.black, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    const SizedBox( width: 20),
    HomeWidget.buildCategoryButton('Recommended', isSelected: true, onPressed: () {
      print('Recommended button pressed');
      check();
    }),
    const SizedBox( width: 20),
    HomeWidget.buildCategoryButton('Popular', onPressed: () {
      print('Popular button pressed');
      check();
    }),
    const SizedBox( width: 20),
    HomeWidget.buildCategoryButton('Trending', onPressed: () {
      print('Trending button pressed');
      check();
    }),
    const SizedBox( width: 20),
    HomeWidget.buildCategoryButton('New Arrive', onPressed: () {
      print('New Arrive button pressed');
      check();
    }),
  ],
),
              ),
              SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    HomeWidget.buildHotelCard(context, 'https://wallpapertag.com/wallpaper/full/a/7/f/509904-beach-paradise-wallpaper-2560x1600-ipad-retina.jpg','Product 1','Dsdfsd, Vũ Trụ', 4.5, 5),
                    const SizedBox(width: 20),
                    HomeWidget.buildHotelCard(context, 'https://wallpapertag.com/wallpaper/full/a/7/f/509904-beach-paradise-wallpaper-2560x1600-ipad-retina.jpg','Product 1','Dsdfsd, Vũ Trụ', 4.5, 5),
                    const SizedBox(width: 20),
                    HomeWidget.buildHotelCard(context, 'https://wallpapertag.com/wallpaper/full/a/7/f/509904-beach-paradise-wallpaper-2560x1600-ipad-retina.jpg','Product 1','Dsdfsd, Vũ Trụ', 4.5, 5),
                    const SizedBox(width: 20),
                    HomeWidget.buildHotelCard(context, 'https://wallpapertag.com/wallpaper/full/a/7/f/509904-beach-paradise-wallpaper-2560x1600-ipad-retina.jpg','Product 1','Dsdfsd, Vũ Trụ', 4.5, 5),
                    const SizedBox(width: 20),
                    HomeWidget.buildHotelCard(context, 'https://wallpapertag.com/wallpaper/full/a/7/f/509904-beach-paradise-wallpaper-2560x1600-ipad-retina.jpg','Product 1','Dsdfsd, Vũ Trụ', 4.5, 5),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recently Booked',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ListHomeScreen()),);
                    },
                    child: Text('See All'),
                  ),
                ],
              ),
              SizedBox(height: 16),
              HomeWidget.buildRecentlyBookedCard('https://wallpapertag.com/wallpaper/full/a/7/f/509904-beach-paradise-wallpaper-2560x1600-ipad-retina.jpg','President Hotel', 'Paris, France', 110, 4.5, 4552),
              HomeWidget.buildRecentlyBookedCard('https://wallpapertag.com/wallpaper/full/a/7/f/509904-beach-paradise-wallpaper-2560x1600-ipad-retina.jpg','President Hotel', 'Amsterdam, Netherlands', 90, 4.7, 2592),
              HomeWidget.buildRecentlyBookedCard('https://wallpapertag.com/wallpaper/full/a/7/f/509904-beach-paradise-wallpaper-2560x1600-ipad-retina.jpg','President Hotel', 'Amsterdam, Netherlands', 90, 4.7, 2592),
            ]
          )
        ),
      )
    );
  }
}
