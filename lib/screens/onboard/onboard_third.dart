import 'package:flutter/material.dart';
import 'package:travelapp/custom_widgests/custom_buttons.dart';
import 'package:travelapp/screens/Intro/create_profile_screen.dart';
import 'package:travelapp/screens/Intro/login_screen.dart';
import 'package:travelapp/screens/onboard/onboard_last.dart';

class ThirdOnboardScreen extends StatelessWidget {
  const ThirdOnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset('Asset/Image/Fund-bro .png'),
            ),
            const SizedBox(height: 40,),
            const Text(
              "Budget Plan",
              style: TextStyle(fontSize: 40),
            ),
            const SizedBox(
              height: 15,
            ),
            const Padding(
              padding: EdgeInsets.only(right: 22, left: 22),
              child: Text(
                'Ready to make the most out of your travels? With our budget recorder, you can easily manage your expenses and stay on track throughout your journey.',
                style: TextStyle(fontSize: 15),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            CustomButton(
                width: 280,
                child: const Text('Next'),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LastOnboardScreen()));
                }),
            const SizedBox(
              height: 5,
            ),
           CustomButton(width: 280,color: Colors.white,
                  child: const Text('Skip'),
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const ProfileCreateScreen()));
                  }),
          ],
        ),
      ),
    );
  }
}
