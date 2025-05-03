import 'package:bookwell/Doctor_s_page/dermatology_doctor.dart';
import 'package:flutter/material.dart';

class Dermatology extends StatefulWidget {
  const Dermatology({super.key});

  @override
  State<Dermatology> createState() => _DermatologyState();
}

class _DermatologyState extends State<Dermatology> {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // Signature Facial Section
              const Text(
                "Signature Facial",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              _buildServiceItem(
                context,
                "Age Defying Facial",
                "A skin treatment that helps reduce the appearance of aging.",
                "assets/images/age_facial.png",
              ),
              _buildServiceItem(
                context,
                "Mattifying Facial",
                "A skincare treatment that uses products to reduce excess oil and give the skin a matte finish.",
                "assets/images/matiffying.png",
              ),
              _buildServiceItem(
                context,
                "Men’s Facial",
                "A skin treatment that cleanses, exfoliates, and massages the face, neck, and décolleté.",
                "assets/images/men.png",
              ),

              const SizedBox(height: 20),

              // Advanced Facial Services Section
              const Text(
                "Advanced Facial Services",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              _buildServiceItem(
                context,
                "Diamond Peel",
                "A non-invasive skin exfoliation procedure that uses a diamond-tipped wand to remove dead skin cells.",
                "assets/images/diamond_peel.png",
              ),
              _buildServiceItem(
                context,
                "Plason",
                "It’s safe for all skin types and can be used on adolescents and adults.",
                "assets/images/plason.png",
              ),

              const SizedBox(height: 20),

              // Dermatological & Cosmetic Services Section
              const Text(
                "Dermatological & Cosmetic Services",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 10),
              _buildServiceItem(
                context,
                "Warts Removal",
                "Wart removal can involve using a variety of treatments.",
                "assets/images/warts_removal.png",
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServiceItem(BuildContext context, String title, String description, String imagePath) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DermatologyDoctor()), // Ensure correct import
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: const Color(0xFF3AB19B),
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
