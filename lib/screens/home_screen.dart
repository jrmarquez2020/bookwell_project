import 'package:bookwell/screens/booking_model.dart';
import 'package:flutter/material.dart';
import 'package:bookwell/screens/History_booking.dart';
import 'package:bookwell/services/Dentist.dart' show ServicesScreen;
import 'package:bookwell/services/Dermatology.dart' show Dermatology;
import 'Profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // List of all categories
  List<Map<String, dynamic>> allCategories = [
    {
      "title": "Dentist",
      "image": "assets/images/Dentist.png",
      "onTap": (BuildContext context) => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ServicesScreen()),
          ),
    },
    {
      "title": "Dermatology",
      "image": "assets/images/Dermatology.png",
      "onTap": (BuildContext context) => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Dermatology()),
          ),
    },
  ];

  List<Map<String, dynamic>> filteredCategories = [];

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredCategories = List.from(allCategories);
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredCategories = allCategories.where((category) {
        return category['title'].toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_selectedIndex == 1) {
      return const HistoryBooking();
    } else if (_selectedIndex == 2) {
      return const Profile();
    }

    // Default Home Page Content
    return Stack(
      children: [
        _buildHeader(),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 205),
              _buildSearchBar(),
              const SizedBox(height: 20),
              _buildCategories(),
              const SizedBox(height: 5),
              _buildDoctorsList(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 240,
      color: const Color(0xFF3AB19B),
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.only(left: 20, bottom: 60),
      child: const Text(
        "Welcome To\nBookWell",
        style: TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              spreadRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
            prefixIcon: const Icon(Icons.search, color: Colors.grey),
            hintText: "Search for categories",
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Categories",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3AB19B),
            ),
          ),
          const SizedBox(height: 15),
          filteredCategories.isEmpty
              ? const Center(child: Text("No Results Found"))
              : GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: filteredCategories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    final category = filteredCategories[index];
                    return _buildCategoryItem(
                      category['title'],
                      category['image'],
                      onTap: () => category['onTap'](context),
                    );
                  },
                ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String title, String imagePath,
      {VoidCallback? onTap}) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildDoctorsList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Doctors",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF3AB19B),
            ),
          ),
          // const SizedBox(height: 10, ),
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: ListView.builder(
                itemCount: doctorsList.length,
                itemBuilder: (context, index) => _buildDoctorItem(
                    doctorsList[index].name,
                    doctorsList[index].specialty,
                    doctorsList[index].image),
              ))
          // _buildDoctorItem(
          //     "Karl Tabudlo", "Dermatologist", "assets/images/Doc1.png"),
          // _buildDoctorItem("Zach King", "Dentist", "assets/images/Doc2.png"),
        ],
      ),
    );
  }

  Widget _buildDoctorItem(String name, String specialty, String imagePath) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            radius: 28,
            backgroundColor: Colors.grey[300],
            backgroundImage: AssetImage(imagePath),
          ),
          title: Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: Text(
            specialty,
            style: const TextStyle(color: Colors.black54, fontSize: 14),
          ),
        ),
        const Divider(),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.grey[200],
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          selectedItemColor: const Color(0xFF3AB19B),
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/images/home.png"), size: 40),
              label: '',
            ),
            BottomNavigationBarItem(
              icon:
                  ImageIcon(AssetImage("assets/images/calendar.png"), size: 30),
              label: '',
            ),
            BottomNavigationBarItem(
              icon:
                  ImageIcon(AssetImage("assets/images/profile.png"), size: 30),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
