import 'package:flutter/material.dart';

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
  DateTime? birthDate; // Thêm biến để lưu ngày sinh
  String? selectedGender;
  int adultGuests = 0;
  int childrenGuests = 0;
  final _formKey = GlobalKey<FormState>();
  final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');
  String? selectedCountryCode = '+84'; // Mã vùng mặc định
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home Booking'),
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
                          icon:
                              Icon(Icons.person, color: Colors.blue, size: 30),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        }),
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
                            return 'Please enter a valid email address (must be @gmail.com)';
                          }
                          return null;
                        }),
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
                            items: <String>[
                              '+84',
                              '+93',
                              '+1',
                              '+44',
                              '+81',
                              '+86',
                              '+91'
                            ].map<DropdownMenuItem<String>>((String value) {
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
                              if (value.length != 10) {
                                return 'Please enter a valid 10-digit phone number';
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
                  }),
              const SizedBox(height: 20),
              Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: GestureDetector(
                  onTap: () => _selectBirthDate(
                      context), // Gọi hàm chọn ngày sinh khi nhấn vào
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          birthDate != null
                              ? "${birthDate!.toLocal()}".split(' ')[0]
                              : "Ngày sinh",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        Icon(Icons.calendar_month,
                            color: Colors.blue, size: 30),
                      ]),
                ),
              ),
              const SizedBox(height: 20),
              Row(children: [
                Expanded(
                    child: TextField(
                  decoration: InputDecoration(
                    icon:
                        Icon(Icons.location_city, color: Colors.blue, size: 30),
                    contentPadding: EdgeInsets.all(15),
                    border: OutlineInputBorder(),
                    labelText: 'Địa chỉ',
                  ),
                ))
              ]),

              const SizedBox(height: 20),
              Divider(color: Colors.grey, thickness: 1), // Đường kẻ ngang

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      readOnly: true,
                      onTap: () => selectDate(context, true),
                      decoration: InputDecoration(
                        labelText: "Check In Date",
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      controller: TextEditingController(
                        text: checkInDate != null
                            ? "${checkInDate!.toLocal()}".split(' ')[0]
                            : "",
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      readOnly: true,
                      onTap: () => selectDate(context, false),
                      decoration: InputDecoration(
                        labelText: "Check Out Date",
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      controller: TextEditingController(
                        text: checkOutDate != null
                            ? "${checkOutDate!.toLocal()}".split(' ')[0]
                            : "",
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      readOnly: true,
                      onTap: () => selectTime(context, true),
                      decoration: InputDecoration(
                        labelText: "Check In Time",
                        suffixIcon: Icon(Icons.access_time),
                      ),
                      controller: TextEditingController(
                        text: checkInTime != null
                            ? checkInTime!.format(context)
                            : "",
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      readOnly: true,
                      onTap: () => selectTime(context, false),
                      decoration: InputDecoration(
                        labelText: "Check Out Time",
                        suffixIcon: Icon(Icons.access_time),
                      ),
                      controller: TextEditingController(
                        text: checkOutTime != null
                            ? checkOutTime!.format(context)
                            : "",
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildGuestCounter("Guest (Adult)", adultGuests, (value) {
                    setState(() => adultGuests = value);
                  }),
                  _buildGuestCounter("Guest (Children)", childrenGuests,
                      (value) {
                    setState(() => childrenGuests = value);
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (checkInDate != null && checkOutDate != null) {
                if (checkInDate!.isAtSameMomentAs(checkOutDate!)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                            'Ngày Check-In và Check-Out không thể trùng nhau!')),
                  );
                } else {
                  // Tích hợp hành động đặt phòng tại đây, ví dụ: lưu dữ liệu hoặc xử lý đặt phòng
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Booking Confirmed'),
                        content: Text('Your booking has been confirmed!'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              }
            }
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black, foregroundColor: Colors.white),
          child: const Text('Book Now', style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }

  // Hàm chọn ngày sinh
  Future<void> _selectBirthDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != birthDate)
      setState(() {
        birthDate = picked;
      });
  }

  // Hàm chọn ngày
  Future<void> selectDate(BuildContext context, bool isCheckIn) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          checkInDate = picked;
        } else {
          if (checkInDate != null && picked.isAtSameMomentAs(checkInDate!)) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content:
                      Text('Ngày Check-Out không thể trùng ngày Check-In')),
            );
          } else {
            checkOutDate = picked;
          }
        }
      });
    }
  }

  // Hàm chọn giờ
  Future<void> selectTime(BuildContext context, bool isCheckIn) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isCheckIn) {
          checkInTime = picked;
        } else {
          checkOutTime = picked;
        }
      });
    }
  }

  // Hàm tạo widget đếm số khách
  Widget _buildGuestCounter(String label, int count, Function(int) onChange) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16)),
        Row(
          children: [
            IconButton(
              onPressed: () {
                if (count > 0) onChange(count - 1);
              },
              icon: Icon(Icons.remove),
            ),
            Text(count.toString(), style: TextStyle(fontSize: 18)),
            IconButton(
              onPressed: () {
                onChange(count + 1);
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}
