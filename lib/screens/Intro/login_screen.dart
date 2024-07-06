// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:travelapp/custom_widgests/custom_buttons.dart';
// import 'package:travelapp/custom_widgests/custom_text.dart';
// import 'package:travelapp/screens/Intro/home_pages_main.dart';
// import 'package:travelapp/screens/Intro/create_profile_screen.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final formkey = GlobalKey<FormState>();
//   final TextEditingController _username = TextEditingController();
//   final TextEditingController _passwordL = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(right: 30, left: 30, top: 200),
//           child: Card(
//             elevation: 5,
//             color: Colors.white, // Adjust the elevation to give a shadow effect
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15.0)),
//             child: Padding(
//               padding: const EdgeInsets.all(15),
//               child: Form(
//                 key: formkey,
//                 child: Column(
//                   children: [
//                     const SizedBox(
//                       height: 40,
//                     ),
//                     SizedBox(
//                       child: Padding(
//                         padding: const EdgeInsets.only(top: 8, bottom: 8),
//                         child: TextFormField(
//                           controller: _username,
//                           autovalidateMode: AutovalidateMode.onUserInteraction,
//                           decoration: InputDecoration(
//                               focusColor: Colors.blue,
//                               filled: true,
//                               fillColor: Colors.white,
//                               labelText: 'Name',
//                               border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(5))),
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return 'please add name ';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 25,
//                     ),
//                     SizedBox(
//                       height: 85,
//                       child: Padding(
//                         padding: const EdgeInsets.only(top: 8, bottom: 8),
//                         child: TextFormField(
//                           controller: _passwordL,
//                           autovalidateMode: AutovalidateMode.onUserInteraction,
//                           decoration: InputDecoration(
//                               filled: true,
//                               fillColor: Colors.white,
//                               labelText: 'Password',
//                               border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(5))),
//                           validator: (value) {
//                             if (value!.isEmpty) {
//                               return 'please add password ';
//                             } else if (value.length < 8) {
//                               return 'please enter minimum 8 characters';
//                             } else if (!value.contains(RegExp(r'[A-Z]')) ||
//                                 !value.contains(RegExp(r'[a-z]'))) {
//                               return 'Password must contain both uppercase and lowercase letters';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     CustomButton(
//                         onPressed: () {
//                           loginbuttonclicked();
//                         },
//                         width: 100,
//                         child: const Text('Login')),
//                     const SizedBox(
//                       height: 75,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const CustomText(text: 'New user signup'),
//                         const SizedBox(
//                           width: 15,
//                         ),
//                         CustomButton(
//                             onPressed: () {
//                               Navigator.pushReplacement(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           const SignUpScreen()));
//                             },
//                             width: 80,
//                             child: const Text('Click here'))
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   loginbuttonclicked() async {
//     if (formkey.currentState!.validate()) {
//       if (_passwordL.text == _passwordL.text) {
//         await setsharedpreference();
//         setState(() {
//           // Navigator.of(context as BuildContext).pushReplacement(
//           //     MaterialPageRoute(builder: (context) => const MyHomePage()));
//           // Navigator.pushAndRemoveUntil(
//           //     context as BuildContext,
//           //     MaterialPageRoute(builder: (context) => MyHomePage()),
//           //     (route) => false);
//           Navigator.pushReplacement(context,
//               MaterialPageRoute(builder: (context) => MyHomePage()));
//         });
//       }
//       // Navigator.push(
//       //     context, MaterialPageRoute(builder: (context) => const MyHomePage()));
//     }
//   }

//   // Future setsharedpreference() async {
//   //   final preference = await SharedPreferences.getInstance();
//   //   preference.setString("My Value", 'true');
//   // }
// }
