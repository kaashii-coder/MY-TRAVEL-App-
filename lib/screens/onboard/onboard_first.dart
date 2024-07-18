import 'package:flutter/material.dart';
import 'package:travelapp/custom_widgests/custom_buttons.dart';
import 'package:travelapp/custom_widgests/custom_text.dart';
import 'package:travelapp/screens/Intro/create_profile_screen.dart';
import 'package:travelapp/screens/onboard/onboard_second.dart';

class FirstOnboardScreen extends StatelessWidget {
  const FirstOnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // const SizedBox(
            //   height: 10,
            // ),
            SizedBox(width: double.infinity,height: 500,child: Image.asset('Asset/Image/Traveling-pana.png',fit: BoxFit.fill,)),
            const Text(
              "Let's Travel",
              style: TextStyle(fontSize: 35),
            ),
            const SizedBox(height: 10,),
            const Padding(
              padding: EdgeInsets.only(right: 10,left: 22),
              child: Text('Embark on a journey  of discovery  with our sleek and user-friendly travel app, right at your fingertips.Welcome to your gateway to unforgettable adventures!'),
            ),
           // CustomText(text: ' Pick the best place for your holiday',size: 20,color: Colors.black,),
           
            const SizedBox(height: 45,),
            CustomButton(width: 280,
                child: const Text('Get started'),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SecondOnboardScreen()));
                }),
                const SizedBox(height: 5,),
                 CustomButton(width: 280,color: Colors.white,
                child: const CustomText(text: 'Skip>>',color: Colors.black,),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileCreateScreen()));
                })
          ],
        ),
      ),
    );
  }
}
