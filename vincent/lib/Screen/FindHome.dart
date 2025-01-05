import 'package:flutter/material.dart';

class HotelSearchScreen extends StatefulWidget {
  @override
  _HotelSearchScreenState createState() => _HotelSearchScreenState();
}

class _HotelSearchScreenState extends State<HotelSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  
  List<Map<String, dynamic>> hotels = [
    {'name': 'Hotel A', 'location': 'New York', 'star': 5, 'price': 200},
    {'name': 'Hotel B', 'location': 'Paris', 'star': 3, 'price': 150},
    {'name': 'Hotel C', 'location': 'Tokyo', 'star': 4, 'price': 220},
    {'name': 'Hotel D', 'location': 'London', 'star': 2, 'price': 100},
  ];

  String searchQuery = '';
  String? selectedLocation;
  int? selectedStar;
  int? selectedPrice;

  List<Map<String, dynamic>> get filteredHotels {
    return hotels.where((hotel) {
      final matchesQuery = searchQuery.isEmpty ||
          hotel['name']!.toLowerCase().contains(searchQuery.toLowerCase()) ||
          hotel['location']!.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesLocation = selectedLocation == null || hotel['location'] == selectedLocation;
      final matchesStar = selectedStar == null || hotel['star'] == selectedStar;
      final matchesPrice = selectedPrice == null || hotel['price'] <= selectedPrice!;
      return matchesQuery && matchesLocation && matchesStar && matchesPrice;
    }).toList();
  }

  List<DropdownMenuItem<String>> get locationDropdownItems {
    return hotels.map((hotel) => hotel['location'] as String).toSet().map((location) {
      return DropdownMenuItem<String>(child: Text(location), value: location);
    }).toList();
  }

  List<DropdownMenuItem<int>> get starDropdownItems => List.generate(5, (index) {
        final starValue = index + 1;
        return DropdownMenuItem<int>(
          child: Text('★' * starValue),
          value: starValue,
        );
      });

  List<DropdownMenuItem<int>> get priceDropdownItems => [
        DropdownMenuItem<int>(child: Text('≤ \$100'), value: 100),
        DropdownMenuItem<int>(child: Text('≤ \$150'), value: 150),
        DropdownMenuItem<int>(child: Text('≤ \$200'), value: 200),
        DropdownMenuItem<int>(child: Text('≤ \$250'), value: 250),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tìm Kiếm Khách Sạn'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Tên hoặc Thành phố',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
            SizedBox(height: 16),
            Row(
              children: [
                DropdownButton<String>(
                  hint: Text('Chọn vị trí'),
                  value: selectedLocation,
                  items: locationDropdownItems,
                  onChanged: (value) {
                    setState(() {
                      selectedLocation = value;
                    });
                  },
                ),
                Spacer(),
                DropdownButton<int>(
                  hint: Text('Sao'),
                  value: selectedStar,
                  items: starDropdownItems,
                  onChanged: (value) {
                    setState(() {
                      selectedStar = value;
                    });
                  },
                ),
                Spacer(),
                DropdownButton<int>(
                  hint: Text('Giá'),
                  value: selectedPrice,
                  items: priceDropdownItems,
                  onChanged: (value) {
                    setState(() {
                      selectedPrice = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredHotels.length,
                itemBuilder: (context, index) {
                  final hotel = filteredHotels[index];
                  return Card(
                    child: ListTile(
                      title: Text(hotel['name']!),
                      subtitle: Text(
                        '${hotel['location']} - ${'★' * hotel['star']} - \$${hotel['price']}',
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
