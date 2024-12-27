import 'package:flutter/material.dart';

class SelectDatePage extends StatefulWidget {
  const SelectDatePage({super.key});

  @override
  _SelectDatePageState createState() => _SelectDatePageState();
}

class _SelectDatePageState extends State<SelectDatePage> {
  DateTime? checkInDate;
  DateTime? checkOutDate;
  TimeOfDay? checkInTime;
  TimeOfDay? checkOutTime;
  int adultGuests = 0;
  int childrenGuests = 0;

  Future<void> _selectDate(BuildContext context, bool isCheckIn) async {
    DateTime initialDate = isCheckIn ? checkInDate ?? DateTime.now() : checkOutDate ?? DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != initialDate) {
      setState(() {
        if (isCheckIn) {
          checkInDate = picked;
        } else {
          checkOutDate = picked;
        }
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isCheckIn) async {
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

  void _updateGuestCount(bool isAdult, bool isIncrement) {
    setState(() {
      if (isAdult) {
        adultGuests = isIncrement ? adultGuests + 1 : (adultGuests > 0 ? adultGuests - 1 : 0);
      } else {
        childrenGuests = isIncrement ? childrenGuests + 1 : (childrenGuests > 0 ? childrenGuests - 1 : 0);
      }
    });
  }

  void _continueBooking() {
    // Add your navigation logic here
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: Text("Booking Summary")),
          body: Center(
            child: Text("Continue booking with the selected details."),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Date'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Date Picker Section
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Check In Date'),
                      GestureDetector(
                        onTap: () => _selectDate(context, true),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            checkInDate != null ? '${checkInDate!.toLocal()}'.split(' ')[0] : 'Select Date',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Check Out Date'),
                      GestureDetector(
                        onTap: () => _selectDate(context, false),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            checkOutDate != null ? '${checkOutDate!.toLocal()}'.split(' ')[0] : 'Select Date',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Time Picker Section
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Check In Time'),
                      GestureDetector(
                        onTap: () => _selectTime(context, true),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            checkInTime != null ? checkInTime!.format(context) : 'Select Time',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Check Out Time'),
                      GestureDetector(
                        onTap: () => _selectTime(context, false),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            checkOutTime != null ? checkOutTime!.format(context) : 'Select Time',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            // Guests Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Guest (Adult)'),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () => _updateGuestCount(true, false),
                        ),
                        Text(adultGuests.toString()),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => _updateGuestCount(true, true),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Guest (Children)'),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () => _updateGuestCount(false, false),
                        ),
                        Text(childrenGuests.toString()),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () => _updateGuestCount(false, true),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            ElevatedButton(
              onPressed: _continueBooking,
              child: Text('Continue'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 64),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
