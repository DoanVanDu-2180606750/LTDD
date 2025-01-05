import 'package:flutter/material.dart';
import 'package:vincent/Screen/HomeDetails.dart';
import 'package:cached_network_image/cached_network_image.dart';


abstract class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});


  static Widget buildCategoryButton(
  String title, {
  bool isSelected = false,
  required VoidCallback onPressed,
}) {
  return TextButton(
    style: TextButton.styleFrom(
      foregroundColor: isSelected ? Colors.white : Colors.black,
      backgroundColor: isSelected ? Colors.black : Colors.grey[200],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    onPressed: onPressed,
    child: Text(title),
  );
}


  static Widget buildHotelCard(
    BuildContext context, String image, String name, String location, double price, double rating) {
  return GestureDetector(
    onTap: () {
      print('$name card tapped');
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeDetailScreen(
        name: name,
        location: location,
        price: price,
        rating: rating,
      )));
    },
    child: Container(
      width: 200,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: image,
            fit: BoxFit.cover,
            width: 200,
            height: 250,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Positioned(
            right: 8,
            top: 8,
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '$rating ⭐',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Positioned(
            bottom: 8,
            left: 8,
            right: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Text(
                  location,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                Text(
                  '\$ $price/ per night',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

static Widget buildRecentlyBookedCard(
    String image, String name, String location, int price, double rating, int reviews) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 90,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: CachedNetworkImage(
          imageUrl: image,
          fit: BoxFit.cover,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
          placeholder: (context, url) => Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
      title: Text(name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(location),
          Row(
            children: [
              Icon(Icons.star, size: 16, color: Colors.orange),
              Text('$rating ($reviews reviews)'),
            ],
          ),
        ],
      ),
      trailing: Text('\$$price / night'),
    );
  }
}
