import 'package:bookwell/firebase_options.dart';
import 'package:bookwell/screens/home_screen.dart';
import 'package:bookwell/screens/splash_screen.dart';
import 'package:bookwell/screens/start.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          }
          if (snapshot.hasData) {
            var userId = snapshot.data!.uid;
            print("ETO YUNG ID: ${userId}");
            return FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(userId)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SplashScreen();
                }

                if (snapshot.hasData) {
                  var data = snapshot.data!.data()!;
                  if (data.isNotEmpty) {
                    return const HomeScreen();
                  }
                }

                return const Start();
              },
            );
          }

          return const Start();
        },
      ),
      builder: EasyLoading.init(),
      // home: Start(),
    );
  }
}
