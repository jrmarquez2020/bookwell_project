import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'booking_model.dart';
import 'history_booking.dart';

class Booking extends StatefulWidget {
  final String doctorName;
  final String department;

  const Booking({
    super.key,
    required this.doctorName,
    required this.department,
  });

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  String _selectedTime = '8:00 AM';
  DateTime _selectedDate = DateTime.now();
  final userId = FirebaseAuth.instance.currentUser!.uid;
  final List<String> _availableTimes = [
    '8:00 AM',
    '8:10 AM',
    '8:20 AM',
    '8:30 AM',
    '8:40 AM',
    '8:50 AM',
    '9:00 AM',
    '9:10 AM',
    '9:20 AM',
    '9:30 AM',
    '9:40 AM',
    '9:50 AM',
    '10:00 AM',
    '10:10 AM',
    '10:20 AM',
    '10:30 AM',
    '10:40 AM',
    '10:50 AM',
    '11:00 AM',
    '1:00 PM',
    '1:10 PM',
    '1:20 PM',
    '1:30 PM',
    '1:40 PM',
    '1:50 PM',
    '2:00 PM',
    '2:10 PM',
    '2:20 PM',
    '2:30 PM',
    '2:40 PM',
    '2:50 PM',
    '3:00 PM',
    '3:10 PM',
    '3:20 PM',
    '3:30 PM',
    '3:40 PM',
    '3:50 PM',
    '4:00 PM',
    '4:10 PM',
    '4:20 PM',
    '4:30 PM',
    '4:40 PM',
    '4:50 PM',
    '5:00 PM'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Book Appointment",
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.history, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HistoryBooking()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text("Select Day",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildDatePicker(),
            const SizedBox(height: 30),
            const Text("Select Time",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildTimePicker(),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _confirmBooking,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3AB19B),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text("Book Now",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    DateTime today = DateTime.now();
    DateTime firstAvailableDate =
        today.isBefore(DateTime(2025, 3, 20)) ? DateTime(2025, 3, 20) : today;

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      child: CalendarDatePicker(
        firstDate: firstAvailableDate,
        lastDate: DateTime(2030),
        initialDate: firstAvailableDate,
        onDateChanged: (newDate) {
          setState(() {
            _selectedDate = newDate;
          });
        },
      ),
    );
  }

  Widget _buildTimePicker() {
    return Stack(
      children: [
        SizedBox(
          height: 120,
          child: ListWheelScrollView.useDelegate(
            controller: FixedExtentScrollController(initialItem: 0),
            itemExtent: 40,
            physics: const FixedExtentScrollPhysics(),
            onSelectedItemChanged: (index) {
              setState(() {
                _selectedTime = _availableTimes[index];
              });
            },
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: _availableTimes.length,
              builder: (context, index) {
                bool isSelected = _selectedTime == _availableTimes[index];
                return Center(
                  child: Text(
                    _availableTimes[index],
                    style: TextStyle(
                      fontSize: isSelected ? 22 : 16,
                      color: isSelected ? Colors.teal : Colors.black,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Positioned(
          top: 40,
          left: MediaQuery.of(context).size.width * 0.30,
          right: MediaQuery.of(context).size.width * 0.30,
          child: const Divider(color: Colors.teal, thickness: 2),
        ),
        Positioned(
          bottom: 40,
          left: MediaQuery.of(context).size.width * 0.30,
          right: MediaQuery.of(context).size.width * 0.30,
          child: const Divider(color: Colors.teal, thickness: 2),
        ),
      ],
    );
  }

  void _confirmBooking() {
    // BookingHistoryData.bookings.add(
    //   BookingModel(
    //     doctorName: widget.doctorName,  // Use dynamic doctor name
    //     department: widget.department,  // Use dynamic department
    //     time: _selectedTime,
    //     date: _selectedDate,
    //   ),
    // );

    FirebaseFirestore.instance.collection('bookings').add({
      'doctor': widget.doctorName,
      'department': widget.department,
      'time': _selectedTime,
      'date': _selectedDate,
      'userId': userId
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(const Duration(seconds: 1), () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        });

        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle, color: Color(0xFF3AB19B), size: 100),
                  SizedBox(height: 25),
                  Text(
                    "The booking was successful!",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
