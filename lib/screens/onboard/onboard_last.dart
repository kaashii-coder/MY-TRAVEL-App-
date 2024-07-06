import 'package:flutter/material.dart';
import 'package:travelapp/custom_widgests/custom_buttons.dart';
import 'package:travelapp/screens/Intro/create_profile_screen.dart';

class LastOnboardScreen extends StatelessWidget {
  const LastOnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 70,
            ),
            Image.asset('Asset/Image/Traveling-rafiki.png'),
            const SizedBox(height: 45,),
            const Text(
              "Start Planning",
              style: TextStyle(fontSize: 40),
              
            ),const SizedBox(height: 10,),
             const Padding(
              padding: EdgeInsets.only(right: 22,left: 35),
              child: Text("Enjoy your holiday! don't forget to take a photo and share to the world.create dream destinations", style: TextStyle(fontSize: 15),),
            ),const SizedBox(height: 20,),
            CustomButton(width: 280,
                child: const Text('Login>>'),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileCreateScreen()));
                }),
          //  CustomButton(width: 280,color: Colors.white,
          //         child: const Text('Signup>>'),
          //         onPressed: () {
          //           Navigator.pushReplacement(context,
          //               MaterialPageRoute(builder: (context) => const SignUpScreen()));
          //         }),
          ],
        ),
      ),
    );
  }
}
