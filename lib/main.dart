import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:travelapp/db/db_model/atripdetail_modal.dart';
import 'package:travelapp/db/db_model/blog_modal.dart';
import 'package:travelapp/db/db_model/trip_model.dart';
import 'package:travelapp/db/db_model/user_model.dart';
import 'package:travelapp/screens/Intro/splash_screen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TripmodelAdapter()); 
  Hive.registerAdapter(UsermodelAdapter());
  Hive.registerAdapter(TripDetailAdapter());
  Hive.registerAdapter(BlogModalAdapter()); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 58, 120, 235),
          ),
          useMaterial3: true,
        ),
        home: const SplashScreen()
        //    FirstOnboardScreen(),
        //hompage()
        // MyAppnew()
        // AddTripscrren()
        //SignUpScreen()
        );
  }
}
