import 'package:bookwell/Doctor_s_page/dentist_doctor.dart';
import 'package:flutter/material.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, // No shadow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context), // Navigate back
        ),
        title: const Text(
          "Services",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              _buildServiceItem(
                context,
                "Teeth Braces",
                "Correcting teeth alignment and bite issues using braces or clear aligners.",
                "assets/images/Braces.png",
              ),
              _buildServiceItem(
                context,
                "Teeth Whitening",
                "Professional teeth whitening to remove stains and discoloration.",
                "assets/images/Cleaning.png",
              ),
              _buildServiceItem(
                context,
                "Teeth Extraction",
                "Removing decayed, damaged, or impacted teeth.",
                "assets/images/Extraction.png",
              ),
              _buildServiceItem(
                context,
                "Dental Check-Up",
                "Routine examination to check for cavities, gum disease, or other dental issues.",
                "assets/images/Check_up.png",
              ),
              _buildServiceItem(
                context,
                "Dental X-Rays",
                "Imaging to detect hidden dental problems such as cavities, bone loss, or impacted teeth.",
                "assets/images/X_ray.png",
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceItem(
    BuildContext context,
    String title,
    String description,
    String imagePath,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DentistDoctor()),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: const Color(0xFF3AB19B), // Green background
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
