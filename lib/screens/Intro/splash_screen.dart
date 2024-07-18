import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelapp/screens/Intro/home_pages_main.dart';
import 'package:travelapp/screens/onboard/onboard_first.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SpashScreenState();
}

class _SpashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    
    super.initState();
     getsharedpreference(context);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      body: Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
        children: [ //SizedBox(height: 300,),
          SizedBox(height: 200,width: 200, child: Image.asset('Asset/Image/checklist.gif'))],),
    ),);
  }
  Future getsharedpreference(BuildContext context) async {
    final preference = await SharedPreferences.getInstance();
    final value = preference.getString('My Value');
    await Future.delayed(const Duration(seconds: 3));
    if (value == 'true') {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MyHomePage(),
          ),
          );
    } else {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const FirstOnboardScreen(),
      ));
    }
  }
}