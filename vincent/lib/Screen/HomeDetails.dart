import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:vincent/Screen/HomeBooking.dart';
import 'package:vincent/Screen/Recently.dart';

final List<String> imgList = [
  'https://cf.bstatic.com/xdata/images/hotel/max500/632334630.jpg?k=8eb97f62ba98edbd4953a50203cad309bac47b5babd995a40208aa59742253b5&o=',
  'https://cf.bstatic.com/xdata/images/hotel/max1024x768/632334702.jpg?k=6c670b53d68deaad401965a87358deed85a71eb908f0d676de651df81289f9aa&o=&hp=1',
  'https://cf.bstatic.com/xdata/images/hotel/max1024x768/632334630.jpg?k=8eb97f62ba98edbd4953a50203cad309bac47b5babd995a40208aa59742253b5&o=&hp=1',
  'https://cf.bstatic.com/xdata/images/hotel/max1024x768/632334670.jpg?k=47a6a841412bf8ba9f740fe3bbea9fe529f61c39945bd72d644c743f553e3c77&o=&hp=1',
  'https://cf.bstatic.com/xdata/images/hotel/max1024x768/632334665.jpg?k=2cb18357d004326f28918206b6d3cbcb1066f59382ec13a7355585734d54c9eb&o=&hp=1',
  'https://cf.bstatic.com/xdata/images/hotel/max1024x768/632334692.jpg?k=5b070cd8b3e6328e0eb670d01d00e09ed65384554073715d6119579015cc19c5&o=&hp=1'
];

class HomeDetailScreen extends StatefulWidget {
  final String name;
  final String location;
  final double price;
  final double rating;
  const HomeDetailScreen({
    super.key,
    required this.name,
    required this.location,
    required this.price,
    required this.rating,
  });

  @override
  State<HomeDetailScreen> createState() => _HomeDetailScreenState();
}

class _HomeDetailScreenState extends State<HomeDetailScreen> {

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(actions: [IconButton(icon: const Icon(Icons.bookmark_add_outlined), onPressed: () {})]),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider.builder(
                itemCount: imgList.length,
                options: CarouselOptions(enlargeCenterPage: true, aspectRatio: 2.0, autoPlay: true, ),
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
                MaterialPageRoute(builder: (context) =>  HomeBookingScreen()));
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
          _buildRoomInfo('${widget.name}', '\$ ${widget.price} / per night'),
          _buildSectionHeader(context, 'Gallery Photos', const RecentlyScreen()),
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
            Text('${widget.rating} /5 ⭐', style: TextStyle(fontSize: 14, color: Colors.black)),
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
