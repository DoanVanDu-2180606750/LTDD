import 'package:flutter/material.dart';
import 'package:vincent/Screen/Recently.dart';
import 'package:vincent/Widgets/home_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
              Text('Recommend', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    HomeWidget.buildHotelCard(context, 'https://cf.bstatic.com/xdata/images/hotel/max1024x768/632334597.jpg?k=e63a019e48f236eb4557d85ba4a0144c19f9ae1f21465e930a70c7e532c4fa65&o=','The Zeit River','Nguyễn Cơ Thạch, Ho Chi Minh City', 90, 5),
                    const SizedBox(width: 20),
                    HomeWidget.buildHotelCard(context, 'https://cf.bstatic.com/xdata/images/hotel/max1024x768/617223226.jpg?k=e03e4f7db41c353667fc5f264183839893dba34541d7e94c2981dbd08555186a&o=','M Village','Phú Nhuận, Hồ Chí Minh', 50, 4),
                    const SizedBox(width: 20),
                    HomeWidget.buildHotelCard(context, 'https://cf.bstatic.com/xdata/images/hotel/max1024x768/624640916.jpg?k=9966482788a36a650b4e43a0690f42251c971800e0c122e7642c6781732dd369&o=','The Peninsula Landmark 81','Binh Thanh, Ho Chi Minh City', 100, 4.5),
                    const SizedBox(width: 20),
                    HomeWidget.buildHotelCard(context, 'https://cf.bstatic.com/xdata/images/hotel/max1024x768/632354078.jpg?k=731bc02aae32a78cd3f6a0a44af4e97501a0dbd52761077835eb71d5959d762b&o=','Masteri Thao Dien','Võ Nguyên Giáp, Ho Chi Minh City', 76, 5),
                    const SizedBox(width: 20),
                    HomeWidget.buildHotelCard(context, 'https://cf.bstatic.com/xdata/images/hotel/max1024x768/481253568.jpg?k=f7bd1fdeee32b6cabb09b943dd11fc76f174d70e5fce82eb2b0a3785244ac5f3&o=','Tin Tin Apartment','District 2, Ho Chi Minh City', 45, 4.8),
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
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RecentlyScreen()),);
                    },
                    child: Text('See All'),
                  ),
                ],
              ),
              SizedBox(height: 16),
              HomeWidget.buildRecentlyBookedCard('https://cf.bstatic.com/xdata/images/hotel/max1024x768/617223226.jpg?k=e03e4f7db41c353667fc5f264183839893dba34541d7e94c2981dbd08555186a&o=','M Village','Phú Nhuận, Hồ Chí Minh', 110, 5, 4552),
              HomeWidget.buildRecentlyBookedCard('https://cf.bstatic.com/xdata/images/hotel/max1024x768/632354078.jpg?k=731bc02aae32a78cd3f6a0a44af4e97501a0dbd52761077835eb71d5959d762b&o=','Masteri Thao Dien','Võ Nguyên Giáp, Ho Chi Minh City', 90, 4.5, 2592),
              HomeWidget.buildRecentlyBookedCard('https://cf.bstatic.com/xdata/images/hotel/max1024x768/481253568.jpg?k=f7bd1fdeee32b6cabb09b943dd11fc76f174d70e5fce82eb2b0a3785244ac5f3&o=','Tin Tin Apartment','District 2, Ho Chi Minh City', 90, 4.7, 564),
            ]
          )
        ),
      )
    );
  }
}
