import 'package:bookwell/Controller/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:bookwell/screens/sign_in.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  var formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  void signUp() async {
    try {
      if(formKey.currentState!.validate()){
        EasyLoading.show();
        final user = await AuthService().signUpWithEmail(
          emailController.text.trim(),
          passwordController.text.trim(),
        );

        var userId = user!.uid;
        FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .set(({'name': nameController.text, 'email': emailController.text}));
          EasyLoading.showSuccess('Account created successfully');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SignIn()),
          );
        
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const Spacer(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                Image.asset(
                  'assets/images/Logo.png',
                  height: 150,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Create an Account",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                      hintText: "Enter your name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12))),
                          validator: (value) {
                            if(value == null || value.isEmpty){
                              return 'This field is required';
                            }

                            return null;
                          },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      hintText: "Enter your email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    if (!EmailValidator.validate(value)) {
                      return 'Invalid email format';
                    }

                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  obscureText: _obscurePassword,
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      icon: Icon(_obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  obscureText: _obscureConfirmPassword,
                  controller: confirmController,
                  decoration: InputDecoration(
                    hintText: "Confirm password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                      icon: Icon(_obscureConfirmPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    if (value != passwordController.text) {
                      return 'Password does not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: (){
                      signUp();
                    },
                    child: const Text(
                      "Continue",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an Account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignIn()),
                        );
                      },
                      child: const Text(
                        "Log in",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
                // const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildTextField(String hint) {
  //   return TextField(
  //     controller: nameController,
  //     decoration: InputDecoration(
  //       hintText: hint,
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(12),
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildEmailField(String hint) {
  //   return TextField(
  //     controller: emailController,
  //     decoration: InputDecoration(
  //       hintText: hint,
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(12),
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildPasswordField(String hint, bool isPassword) {
  //   return TextField(
  //     controller: passwordController,
  //     obscureText: isPassword ? _obscurePassword : _obscureConfirmPassword,
  //     decoration: InputDecoration(
  //       hintText: hint,
  //       border: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(12),
  //       ),
  //       suffixIcon: IconButton(
  //         icon: Icon(
  //           isPassword
  //               ? (_obscurePassword ? Icons.visibility_off : Icons.visibility)
  //               : (_obscureConfirmPassword ? Icons.visibility_off : Icons.visibility),
  //         ),
  //         onPressed: () {
  //           setState(() {
  //             if (isPassword) {
  //               _obscurePassword = !_obscurePassword;
  //             } else {
  //               _obscureConfirmPassword = !_obscureConfirmPassword;
  //             }
  //           });
  //         },
  //       ),
  //     ),
  //   );
  // }
}
