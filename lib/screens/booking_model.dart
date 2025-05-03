class BookingModel {
  final String doctorName;
  final String department;
  final String time;
  final DateTime date;

  BookingModel({
    required this.doctorName,
    required this.department,
    required this.time,
    required this.date,
  });
}

class BookingHistoryData {
  static List<BookingModel> bookings = [];
}

class Doctor {
  final String name;
  final String specialty;
  final String image;

  Doctor({required this.name, required this.specialty, required this.image});
}

List<Doctor> doctorsList = [
  Doctor(
      name: 'Isabelle Grate',
      specialty: 'Dermatology',
      image: "assets/images/Doc2.png"),
  Doctor(
      name: 'Lily Crux',
      specialty: 'Dermatology',
      image: "assets/images/Doc1.png"),
  Doctor(
      name: 'Karl Tabuldo',
      specialty: 'Dentist',
      image: "assets/images/Doc2.png"),
  Doctor(
      name: 'Albert Yu', specialty: 'Dentist', image: "assets/images/Doc1.png"),
];
