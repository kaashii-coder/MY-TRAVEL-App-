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
    // TODO: implement initState
    super.initState();
     getsharedpreference(context);

  }
  Widget build(BuildContext context) {
    return Scaffold(body: Padding(
      padding: const EdgeInsets.all(80.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
        children: [Image.asset('Asset/Image/checklist.gif')],),
    ),);
  }
  Future getsharedpreference(BuildContext context) async {
    final preference = await SharedPreferences.getInstance();
    final value = preference.getString('My Value');
    await Future.delayed(const Duration(seconds: 3));
    if (value == 'true') {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MyHomePage(),
          ),
          );
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => FirstOnboardScreen(),
      ));
    }
  }
}