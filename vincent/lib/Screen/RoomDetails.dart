import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:vincent/Screen/DayBooking.dart';
import 'package:vincent/Screen/RoomList.dart';
import 'package:vincent/Widgets/home_widget.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class RoomDetailScreen extends StatefulWidget {
  const RoomDetailScreen({super.key});

  @override
  State<RoomDetailScreen> createState() => _RoomDetailScreenState();
}

class _RoomDetailScreenState extends State<RoomDetailScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(actions: [IconButton(icon: const Icon(Icons.bookmark_add_outlined), onPressed: () {})]),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider.builder(
                itemCount: imgList.length,
                options: CarouselOptions(enlargeCenterPage: true, aspectRatio: 2.0, autoPlay: true),
                itemBuilder: (ctx, index, realIdx) => Container(
                  width: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(image: NetworkImage(imgList[index]), fit: BoxFit.cover),
                  ),
                ),
              ),
              _buildRoomDetails(context),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  SelectDatePage()));
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white),
            child: const Text('Book Now', style: TextStyle(fontSize: 18)),
          ),
        ),
      );

  Widget _buildRoomDetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRoomInfo('Room Name', '\$ Price / per night'),
          _buildSectionHeader(context, 'Gallery Photos', const RoomListScreen()),
          _buildImageRow(),
          const SizedBox(height: 8),
          _buildDetailsSection(),
          const SizedBox(height: 8),
          _buildDescriptionSection(),
          const SizedBox(height: 8),
          _buildFacilitiesSection(),
          _buildLocationSection(),
          _buildReviewSection(context),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildRoomInfo(String name, String price) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(price, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Divider(thickness: 1, color: Colors.grey),
        ],
      );

  Widget _buildSectionHeader(BuildContext context, String title, Widget destination) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          TextButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => destination)),
            child: const Text('See All'),
          ),
        ],
      );

  Widget _buildImageRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(4, (index) {
          return _buildHotelCard( imgList[index]);
        }),
      ),
    );
  }

  Widget _buildHotelCard( String image,) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          width: 200,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: NetworkImage(image),
              fit: BoxFit.cover,
            ),
          ),
      ),
    );
  }

  Widget _buildDetailsSection() {
    return Column(
      children: [
        const Text('Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildDetailIcon(Icons.business, 'Loại'),
            _buildDetailIcon(Icons.hotel, 'Số giường'),
            _buildDetailIcon(Icons.group, 'Số người'),
            _buildDetailIcon(Icons.room, 'Vị trí'),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailIcon(IconData icon, String label){
    return Column(
      children: [
        Icon(icon, color: Colors.green, size: 50),
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.black)),
      ],
    );
  }

  Widget _buildDescriptionSection() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Description', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const SizedBox(
            height: 80,
            child: Text('Description of the room goes here', style: TextStyle(fontSize: 14, color: Colors.black)),
          ),
          const Divider(thickness: 1, color: Colors.grey),
        ],
      );

  Widget _buildFacilitiesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Facilities', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 50,
          runSpacing: 20,
          children: [
            _buildFacilityIcon(Icons.fitness_center, 'Gym'),
            _buildFacilityIcon(Icons.fingerprint, 'Security'),
            _buildFacilityIcon(Icons.alarm, 'Alarm'),
            _buildFacilityIcon(Icons.cast, 'Cast'),
            _buildFacilityIcon(Icons.wifi, 'WiFi'),
            _buildFacilityIcon(Icons.local_dining, 'Dining'),
            _buildFacilityIcon(Icons.pool, 'Pool'),
          ],
        ),
      ],
    );
  }

  Widget _buildFacilityIcon(IconData icon, String label) => Column(
        children: [
          Icon(icon, color: Colors.green, size: 50),
          Text(label, style: const TextStyle(fontSize: 14, color: Colors.black)),
        ],
      );

  Widget _buildLocationSection() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Location', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              IconButton(
                onPressed: (){}, 
                icon: Icon(Icons.arrow_forward),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.grey),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Container(height: 150, width: double.infinity, color: Colors.grey[300]),
        ],
      );

  Widget _buildReviewSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Review', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Text('4.5/5 ⭐', style: TextStyle(fontSize: 14, color: Colors.black)),
          ],
        ),
        _buildReviewCard(),
        const SizedBox(height: 10),
        _buildReviewCard(),
        const SizedBox(height: 10),
        _buildReviewCard(),
        const SizedBox(height: 10),
        _buildReviewCard(),
        const SizedBox(height: 10),
        _buildReviewCard(),
      ],
    );
  }

  Widget _buildReviewCard() {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[300],
      borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage('https://i.pravatar.cc/200'),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      children: [
                        Text('John Doe', style: TextStyle(fontSize: 16, color: Colors.black)),
                        Text('2022-01-01', style: TextStyle(fontSize: 14, color:Colors.black),),
                      ],
                    ),
                  ]
                ),
                Container(
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text('5 ⭐', style: TextStyle(fontSize: 14, color: Colors.black)
                    )
                  )
                ),
              ]
            ),
            const SizedBox(height: 10),
            Text(
              'This is a review.',
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
