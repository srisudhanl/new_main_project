import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:main_project1/custom_widgets/custom_text_field.dart';
import 'package:main_project1/toast_manager.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _resetPassword(BuildContext context) async {
    try {
      await _auth.sendPasswordResetEmail(email: _emailController.text.trim());
      ToastManager.showToastShort(msg: 'Password reset email sent. Check your inbox.');
    } catch (error) {
      ToastManager.showToastShort(msg: 'Failed to send password reset email: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Forget Password',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            // fontSize: 15.0,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 300,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/forget_image.jpg"), fit: BoxFit.cover),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 450,
                decoration: const BoxDecoration(
                    boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10)],
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                    image: DecorationImage(image: AssetImage("assets/background.jpeg"), fit: BoxFit.cover)),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: const Center(
                        child: Text(
                          "Reset your password vibes: Drop your email and let the magic happen! 🌟",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20),
                      child: buildTextField(
                          labelText: "Email",
                          hintText: "abc@gmail.com",
                          textInputType: TextInputType.emailAddress,
                          textEditingController: _emailController,
                          prefixIcon: Icon(Icons.alternate_email_rounded)),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () => _resetPassword(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: const Text("Send mail", style: TextStyle(color: Colors.white)),
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: const Text("Cancel", style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
