import 'package:flutter/material.dart';
import 'package:vincent/Screen/Payment.dart';

class HomeBookingScreen extends StatefulWidget {
  const HomeBookingScreen({super.key});

  @override
  _HomeBookingScreenState createState() => _HomeBookingScreenState();
}

class _HomeBookingScreenState extends State<HomeBookingScreen> {
  DateTime? checkInDate, checkOutDate, birthDate;
  TimeOfDay? checkInTime, checkOutTime;
  String? selectedGender, selectedCountryCode = '+84';
  int adultGuests = 1, childrenGuests = 0;
  final _formKey = GlobalKey<FormState>();
  final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  String? _emailError, _phoneError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Home Booking')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextFormField(
                label: 'Họ Tên:',
                icon: Icons.person,
                validator: (value) => value?.isEmpty ?? true ? 'Please enter your name' : null,
              ),
              SizedBox(height: 20),
              _buildEmailField(),
              SizedBox(height: 20),
              _buildPhoneNumberField(),
              SizedBox(height: 20),
              _buildGenderDropdown(),
              SizedBox(height: 20),
              _buildDateSelector(
                displayText: birthDate != null ? "${birthDate!.toLocal()}".split(' ')[0] : "Ngày sinh",
                onTap: () => _selectBirthDate(context),
                icon: Icons.calendar_month,
              ),
              SizedBox(height: 20),
              _buildTextFormField(
                label: 'Địa chỉ',
                icon: Icons.location_city,
              ),
              SizedBox(height: 20),
              Divider(color: Colors.grey),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildReadOnlyField(
                    label: "Check In Date",
                    text: checkInDate?.toLocal().toString().split(' ')[0] ?? "",
                    onTap: () => _selectDate(context, true),
                    icon: Icons.calendar_today,
                  ),
                  SizedBox(width: 16),
                  _buildReadOnlyField(
                    label: "Check Out Date",
                    text: checkOutDate?.toLocal().toString().split(' ')[0] ?? "",
                    onTap: () => _selectDate(context, false),
                    icon: Icons.calendar_today,
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildReadOnlyField(
                    label: "Check In Time",
                    text: checkInTime?.format(context) ?? "",
                    onTap: () => _selectTime(context, true),
                    icon: Icons.access_time,
                  ),
                  SizedBox(width: 16),
                  _buildReadOnlyField(
                    label: "Check Out Time",
                    text: checkOutTime?.format(context) ?? "",
                    onTap: () => _selectTime(context, false),
                    icon: Icons.access_time,
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildGuestCounter("Guest (Adult)", adultGuests, (value) => setState(() => adultGuests = value)),
                  _buildGuestCounter("Guest (Children)", childrenGuests, (value) => setState(() => childrenGuests = value)),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          onPressed: _onBookingPressed,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white),
          child: const Text('Book Now', style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }

  // Helper Method to create ReadOnly TextField for date and time
  Widget _buildReadOnlyField({required String label, required String text, required VoidCallback onTap, required IconData icon}) {
    return Expanded(
      child: TextField(
        readOnly: true,
        onTap: onTap,
        decoration: InputDecoration(labelText: label, suffixIcon: Icon(icon)),
        controller: TextEditingController(text: text),
      ),
    );
  }

  // Helper Method to create a TextFormField
  Widget _buildTextFormField({required String label, required IconData icon, FormFieldValidator<String>? validator}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        icon: Icon(icon, color: Colors.blue, size: 30),
        border: OutlineInputBorder(),
      ),
      validator: validator,
    );
  }

  // Email field with immediate validation
  Widget _buildEmailField() {
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(
        labelText: 'Email:',
        icon: Icon(Icons.email, color: Colors.blue, size: 30),
        border: OutlineInputBorder(),
        errorText: _emailError,
      ),
      onChanged: (value) {
        setState(() {
          if (value.isEmpty) {
            _emailError = 'Please enter your email';
          } else if (!regex.hasMatch(value)) {
            _emailError = 'Must be @gmail.com';
          } else {
            _emailError = null;
          }
        });
      },
    );
  }

  // Phone number field with immediate validation
  Widget _buildPhoneNumberField() {
    return Row(
      children: [
        _buildCountryCodeDropdown(),
        SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            controller: phoneController,
            decoration: InputDecoration(
              hintText: 'Phone Number',
              border: OutlineInputBorder(),
              errorText: _phoneError,
            ),
            keyboardType: TextInputType.phone,
            onChanged: (value) {
              setState(() {
                if (value.isEmpty) {
                  _phoneError = 'Please enter your phone number';
                } else if (value.length != 10) {
                  _phoneError = 'Please enter a valid 10-digit phone number';
                } else {
                  _phoneError = null;
                }
              });
            },
          ),
        ),
      ],
    );
  }

  // Method to create a DropDown for country code selection
  Widget _buildCountryCodeDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8)),
      child: DropdownButton<String>(
        value: selectedCountryCode,
        onChanged: (newValue) => setState(() => selectedCountryCode = newValue),
        underline: SizedBox(),
        items: <String>['+84', '+93', '+1', '+44', '+81', '+86', '+91']
            .map<DropdownMenuItem<String>>((value) => DropdownMenuItem<String>(value: value, child: Text(value)))
            .toList(),
        icon: Icon(Icons.arrow_drop_down),
      ),
    );
  }

  // Method to create gender selection drop down
  Widget _buildGenderDropdown() {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        icon: Icon(Icons.transgender, color: Colors.blue, size: 30),
        contentPadding: EdgeInsets.all(15),
        border: OutlineInputBorder(),
      ),
      value: selectedGender,
      items: ['Nam', 'Nữ', 'Khác']
          .map((gender) => DropdownMenuItem(value: gender, child: Text(gender)))
          .toList(),
      onChanged: (value) => setState(() => selectedGender = value),
    );
  }

  // Method to create date selection row
  Widget _buildDateSelector({required String displayText, required VoidCallback onTap, required IconData icon}) {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(8)),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(displayText, style: TextStyle(fontSize: 16, color: Colors.grey)),
            Icon(icon, color: Colors.blue, size: 30),
          ],
        ),
      ),
    );
  }

  // Method to handle booking process
  void _onBookingPressed() {
    if (_formKey.currentState != null && !_formKey.currentState!.validate()) {
      // The form state might be null or the validation failed
      _showMessage('Please correct the errors in the form.');
      return;
    }

    if (!_isAgeValid()) {
      _showMessage('Tuổi phải lớn hơn 18 để đặt phòng!');
      return;
    }

    if (checkInDate == null || checkOutDate == null) {
      _showMessage('Vui lòng chọn ngày Check-In và Check-Out!');
      return;
    }

    if (checkInDate!.isAtSameMomentAs(checkOutDate!) && checkInTime != null && checkOutTime != null && checkInTime == checkOutTime) {
      _showMessage('Nếu check-in và check-out cùng ngày, thời gian không được trùng!');
      return;
    }

    if (_isCheckInBeforeCheckOut()) {
      _showConfirmationDialog();
    } else {
      _showMessage('Please ensure check-in is before check-out.');
    }
  }

  // Asynchronous method to select date
  Future<void> _selectBirthDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => birthDate = picked);
  }

  // Method for selecting check-in/out date
  Future<void> _selectDate(BuildContext context, bool isCheckIn) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isCheckIn) checkInDate = picked;
        else checkOutDate = picked;
      });
    }
  }

  // Method for selecting check-in/out time
  Future<void> _selectTime(BuildContext context, bool isCheckIn) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) setState(() => isCheckIn ? checkInTime = picked : checkOutTime = picked);
  }

  // Widget to build guest counter
  Widget _buildGuestCounter(String label, int count, Function(int) onChange) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16)),
        Row(
          children: [
            IconButton(onPressed: () => onChange(count > 1 ? count - 1 : 1), icon: Icon(Icons.remove)),
            Text(count.toString(), style: TextStyle(fontSize: 18)),
            IconButton(onPressed: () => onChange(count + 1), icon: Icon(Icons.add)),
          ],
        ),
      ],
    );
  }

  // Helper function to check if check-in is before check-out
  bool _isCheckInBeforeCheckOut() {
    bool valid = checkInDate!.isBefore(checkOutDate!) || 
                 (checkInDate!.isAtSameMomentAs(checkOutDate!) && 
                 checkInTime!.hour < checkOutTime!.hour) || 
                 (checkInDate!.isAtSameMomentAs(checkOutDate!) && 
                 checkInTime!.hour == checkOutTime!.hour && 
                 checkInTime!.minute < checkOutTime!.minute);

    if (!valid) _showMessage('Check-in phải trước check-out.');
    return valid;
  }

  // Helper function to check if the user is above 18
  bool _isAgeValid() {
    if (birthDate == null) return false;
    final today = DateTime.now();
    final age = today.year - birthDate!.year - ((today.month < birthDate!.month || (today.month == birthDate!.month && today.day < birthDate!.day)) ? 1 : 0);
    return age > 18;
  }

  // Helper function to show a message
  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  // Method to show confirmation dialog
  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Booking Confirmed'),
        content: Text('Your booking has been confirmed!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentScreen()));
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
