import 'package:flutter/material.dart';
import 'package:travelapp/custom_widgests/custom_buttons.dart';
import 'package:travelapp/screens/Intro/login_screen.dart';
import 'package:travelapp/screens/onboard/onboard_third.dart';

class SecondOnboardScreen extends StatelessWidget {
  const SecondOnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 60,
              ),
              SizedBox(width:double.infinity ,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Image.asset(
                    'Asset/Image/Around the world-amico.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(height: 55,),
              const Text(
                "Destinations",
                style: TextStyle(fontSize: 35),
              ),const SizedBox(height: 10,),
              const Padding(
                padding: EdgeInsets.only(left: 28),
                child: Text('Where will your next adventure take you? Choose your dream destination and let our travel app guide you to extraordinary experiences'),
              ),
              const SizedBox(height: 30,),
              CustomButton(width: 280,
                  child: const Text('Next'),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ThirdOnboardScreen()));
                  }),  const SizedBox(height: 5,),
              CustomButton(width: 280,color: Colors.white,
                  child: const Text('Skip'),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
