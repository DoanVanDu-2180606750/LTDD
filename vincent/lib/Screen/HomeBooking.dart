import 'package:flutter/material.dart';
import 'package:vincent/Screen/InfoBooking.dart';

class HomeBookingScreen extends StatefulWidget {
  const HomeBookingScreen({super.key});

  @override
  _HomeBookingScreenState createState() => _HomeBookingScreenState();
}

class _HomeBookingScreenState extends State<HomeBookingScreen> {
  DateTime? checkInDate;
  DateTime? checkOutDate;
  TimeOfDay? checkInTime;
  TimeOfDay? checkOutTime;
  String? selectedGender;
  int adultGuests = 0;
  int childrenGuests = 0;
  final _formKey = GlobalKey<FormState>();
  final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  String? selectedCountryCode = '+84';  // Mã vùng mặc định
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Info Booking'),
      ),
      body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Họ Tên:',
                      icon: Icon(Icons.person, color: Colors.blue, size: 30),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    }
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email:',
                      icon: Icon(Icons.email, color: Colors.blue, size: 30),
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!regex.hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    }
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButton<String>(
                          value: selectedCountryCode,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedCountryCode = newValue;
                            });
                          },
                          underline: SizedBox(),
                          items: <String>['+84', '+93', '+1', '+44', '+81', '+86', '+91']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          icon: Icon(Icons.arrow_drop_down),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: phoneController,
                          decoration: InputDecoration(
                            hintText: 'Phone Number',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            if (value.length < 10) { 
                              return 'Please enter a valid phone number';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.transgender, color: Colors.blue, size: 30),
                contentPadding: EdgeInsets.all(15),
                border: OutlineInputBorder(),
              ),
              value: selectedGender,
              items: [
                DropdownMenuItem(value: 'Nam', child: Text('Nam')),
                DropdownMenuItem(value: 'Nữ', child: Text('Nữ')),
                DropdownMenuItem(value: 'Khác', child: Text('Khác')),
              ],
              onChanged: (value) {
                setState(() {
                  selectedGender = value;
                });
              }
            ),
            const SizedBox(height: 20),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: GestureDetector(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ngày sinh',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    Icon(Icons.calendar_month, color: Colors.blue, size: 30),
                  ]
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.location_city, color: Colors.blue, size: 30),
                      contentPadding: EdgeInsets.all(15),
                      border: OutlineInputBorder(),
                      labelText: 'Địa chỉ',
                    ),
                  )
                )
              ]
            )
          ],
        ),
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
  }
}
